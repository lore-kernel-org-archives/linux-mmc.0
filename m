From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH RESEND 12/12] ARM: dts: berlin: Enable eMMC on Sony NSZ-GS7
Date: Tue, 21 Oct 2014 11:22:44 +0200
Message-ID: <1413883364-681-13-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

V2l0aCBTREhDSSBmb3IgQkcyLCB3ZSBjYW4gbm93IGVuYWJsZSB0aGUgcG9ydCBhbmQgYWxsb3cg
dG8gYWNjZXNzClNhbXN1bmcgTThHMkZBIDhHQiBlTU1DIG9uIFNvbnkgTlNaLUdTNy4KClNpZ25l
ZC1vZmYtYnk6IFNlYmFzdGlhbiBIZXNzZWxiYXJ0aCA8c2ViYXN0aWFuLmhlc3NlbGJhcnRoQGdt
YWlsLmNvbT4KLS0tCkNjOiBDaHJpcyBCYWxsIDxjaHJpc0BwcmludGYubmV0PgpDYzogVWxmIEhh
bnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+CkNjOiAiQW50b2luZSBUw6luYXJ0IiA8YW50
b2luZS50ZW5hcnRAZnJlZS1lbGVjdHJvbnMuY29tPgpDYzogbGludXgtbW1jQHZnZXIua2VybmVs
Lm9yZwpDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwotLS0K
IGFyY2gvYXJtL2Jvb3QvZHRzL2JlcmxpbjItc29ueS1uc3otZ3M3LmR0cyB8IDcgKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2JlcmxpbjItc29ueS1uc3otZ3M3LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2Jlcmxp
bjItc29ueS1uc3otZ3M3LmR0cwppbmRleCBjNzJiZmQ0NjhkMTAuLjVlNWYzYTkwZTQ2NSAxMDA2
NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYmVybGluMi1zb255LW5zei1nczcuZHRzCisrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2JlcmxpbjItc29ueS1uc3otZ3M3LmR0cwpAQCAtMjYsNCArMjYs
MTEgQEAKIAl9OwogfTsKIAorLyogU2Ftc3VuZyBNOEcyRkEgOEdCIGVNTUMgKi8KKyZzZGhjaTIg
eworCW5vbi1yZW1vdmFibGU7CisJYnVzLXdpZHRoID0gPDg+OworCXN0YXR1cyA9ICJva2F5IjsK
K307CisKICZ1YXJ0MCB7IHN0YXR1cyA9ICJva2F5IjsgfTsKLS0gCjIuMS4xCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
