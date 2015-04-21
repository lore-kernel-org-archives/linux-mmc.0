From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v2 RESEND 0/2] Add SDHCI support for APM X-Gene SoC using
 ARASAN SDHCI controller.
Date: Tue, 21 Apr 2015 21:12:37 +0530
Message-ID: <1429630959-32649-1-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: chris@printf.net, ulf.hansson@linaro.org, anton@enomsg.org, arnd@arndb.de
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com, Suman Tripathi <stripathi@apm.com>, jcm@redhat.com, linux-mmc@vger.kernel.org, patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBTREhDSSBzdXBwb3J0IGZvciBBUE0gWC1HZW5lIFNvQyB1c2lu
ZyBBUkFTQU4gU0RIQ0kgY29udHJvbGxlci4KCnYxIGNoYW5nZToKICogVXNlIHRoZSBDT05GSUdf
QVJNNjRfRE1BX0hBU19JT01NVSBmb3IgZG1hLW1hcHBpbmcuCgp2MiBjaGFuZ2U6CiAqIERyb3Ag
dGhlIElPTU1VIHN1cHBvcnQgYW5kIHN3aXRjaGluZyB0byBQSU8gbW9kZSBmb3IgYXJhc2FuIAog
ICBjb250cm9sbGVyIGludGVncmF0ZWQgaW5zaWRlIEFQTSBYLUdlbmUgU29DLgoKU2lnbmVkLW9m
Zi1ieTogU3VtYW4gVHJpcGF0aGkgPHN0cmlwYXRoaUBhcG0uY29tPgoKU3VtYW4gVHJpcGF0aGkg
KDIpOgogIGFybTY0OiBkdHM6IEFkZCB0aGUgYXJhc2FuIHNkaGMgbm9kZXMgaW4gYXBtLXN0b3Jt
LmR0c2kuCiAgbW1jOiBob3N0OiBBZGQgc29tZSBxdWlya3MgdG8gYmUgcmVhZCBmcm9tIGZkdCBp
biBzZGhjaS1wbHRtLmMKCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2FwbS1zdG9ybS5kdHNpIHwgNDQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktcGx0Zm0uYyAgICAgfCAxNSArKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDU5
IGluc2VydGlvbnMoKykKCi0tIAoxLjguMi4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRl
dkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51
eHBwYy1kZXY=
