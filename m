From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 3/5] ARM: dts: stm32: add sdmmc support for stm32h743
Date: Wed, 28 Feb 2018 16:47:22 +0100
Message-ID: <1519832844-28068-4-git-send-email-ludovic.Barre@st.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

RnJvbTogTHVkb3ZpYyBCYXJyZSA8bHVkb3ZpYy5iYXJyZUBzdC5jb20+CgpUaGlzIHBhdGNoIGFk
ZHMgc2RtbWMgc3VwcG9ydCBmb3Igc3RtMzJoNzQzLgoyw5dTRC9TRElPL01NQyBpbnRlcmZhY2Vz
ICh1cCB0byAxMjUgTUh6KQoKU2lnbmVkLW9mZi1ieTogTHVkb3ZpYyBCYXJyZSA8bHVkb3ZpYy5i
YXJyZUBzdC5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJoNzQzLmR0c2kgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMmg3NDMuZHRzaSBiL2FyY2gv
YXJtL2Jvb3QvZHRzL3N0bTMyaDc0My5kdHNpCmluZGV4IGJiZmNiYWMuLjVlODU1MzggMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyaDc0My5kdHNpCisrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL3N0bTMyaDc0My5kdHNpCkBAIC0yMTcsNiArMjE3LDE5IEBACiAJCQl9OwogCQl9Owog
CisJCXNkbW1jMjogc2RtbWNANDgwMjI0MDAgeworCQkJY29tcGF0aWJsZSA9ICJzdCxzdG0zMmg3
LXNkbW1jIjsKKwkJCXJlZyA9IDwweDQ4MDIyNDAwIDB4NDAwPjsKKwkJCXJlZy1uYW1lcyA9ICJz
ZG1tYyI7CisJCQlpbnRlcnJ1cHRzID0gPDEyND47CisJCQljbG9ja3MgPSA8JnJjYyBTRE1NQzJf
Q0s+OworCQkJcmVzZXRzID0gPCZyY2MgU1RNMzJIN19BSEIyX1JFU0VUKFNETU1DMik+OworCQkJ
Y2FwLXNkLWhpZ2hzcGVlZDsKKwkJCWNhcC1tbWMtaGlnaHNwZWVkOworCQkJbWF4LWZyZXF1ZW5j
eSA9IDwxMjUwMDAwMDA+OworCQkJc3RhdHVzID0gImRpc2FibGVkIjsKKwkJfTsKKwogCQltZG1h
MTogZG1hQDUyMDAwMDAwIHsKIAkJCWNvbXBhdGlibGUgPSAic3Qsc3RtMzJoNy1tZG1hIjsKIAkJ
CXJlZyA9IDwweDUyMDAwMDAwIDB4MTAwMD47CkBAIC0yMjcsNiArMjQwLDE5IEBACiAJCQlkbWEt
cmVxdWVzdHMgPSA8MzI+OwogCQl9OwogCisJCXNkbW1jMTogc2RtbWNANTIwMDcwMDAgeworCQkJ
Y29tcGF0aWJsZSA9ICJzdCxzdG0zMmg3LXNkbW1jIjsKKwkJCXJlZyA9IDwweDUyMDA3MDAwIDB4
MTAwMD47CisJCQlyZWctbmFtZXMgPSAic2RtbWMiOworCQkJaW50ZXJydXB0cyA9IDw0OT47CisJ
CQljbG9ja3MgPSA8JnJjYyBTRE1NQzFfQ0s+OworCQkJcmVzZXRzID0gPCZyY2MgU1RNMzJIN19B
SEIzX1JFU0VUKFNETU1DMSk+OworCQkJY2FwLXNkLWhpZ2hzcGVlZDsKKwkJCWNhcC1tbWMtaGln
aHNwZWVkOworCQkJbWF4LWZyZXF1ZW5jeSA9IDwxMjUwMDAwMDA+OworCQkJc3RhdHVzID0gImRp
c2FibGVkIjsKKwkJfTsKKwogCQlscHRpbWVyMjogdGltZXJANTgwMDI0MDAgewogCQkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47CiAJCQkjc2l6ZS1jZWxscyA9IDwwPjsKLS0gCjIuNy40CgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
