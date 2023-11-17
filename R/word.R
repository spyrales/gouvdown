# Copyright 2020 République Française
#
# Licensed under the EUPL, Version 1.2 or – as soon they will be approved by
# the European Commission - subsequent versions of the EUPL (the "Licence");
# You may not use this work except in compliance with the Licence.
# You may obtain a copy of the Licence at:
#
# https://joinup.ec.europa.eu/software/page/eupl
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the Licence is distributed on an "AS IS" basis,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Licence for the specific language governing permissions and
# limitations under the Licence.

#' Word output format for creating a docx letter
#'
#' @inheritParams rmarkdown::word_document
#' @param ... Additional arguments passed to \code{rmarkdown::\link{word_document}()}.
#'
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
#'

lettre_word <- function(reference_docx = pkg_resource("docx", "template_lettre.docx"), ...){
  rmarkdown::word_document(reference_docx = reference_docx, ...)
}
