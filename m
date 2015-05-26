From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH RESEND v7 1/2] arm64: dts: Add the arasan mmc nodes in
 apm-storm.dtsi
Date: Tue, 26 May 2015 16:34:42 +0530
Message-ID: <CAOHikRCtvC7Y0K+1Gx-Qax9xH=gsBTbqBOLzKtfQ-NXoZ6VDkA@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
 <1432197817-22110-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0713068372278960775=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1432197817-22110-2-git-send-email-stripathi@apm.com>
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
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Suman Tripathi <stripathi@apm.com>, Jon Masters <jcm@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============0713068372278960775==
Content-Type: multipart/alternative; boundary=047d7b66f445f3c5bd0516fa17ba

--047d7b66f445f3c5bd0516fa17ba
Content-Type: text/plain; charset=UTF-8

Hi ,

On Thu, May 21, 2015 at 2:13 PM, Suman Tripathi <stripathi@apm.com> wrote:

> This patch adds the arasan mmc nodes to reuse the of-arasan
> driver for APM X-Gene SoC.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
> ---
>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43
> +++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts
> b/arch/arm64/boot/dts/apm/apm-mustang.dts
> index 83578e7..7a3ea72 100644
> --- a/arch/arm64/boot/dts/apm/apm-mustang.dts
> +++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
> @@ -52,3 +52,7 @@
>  &xgenet {
>         status = "ok";
>  };
> +
> +&mmc0 {
> +       status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index c8d3e0e..8e03ecd 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -145,6 +145,40 @@
>                                 clock-output-names = "socplldiv2";
>                         };
>
> +                       ahbclk: ahbclk@1f2ac000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
> +                                       0x0 0x17000000 0x0 0x2000>;
> +                               reg-names = "csr-reg", "div-reg";
> +                               csr-offset = <0x0>;
> +                               csr-mask = <0x1>;
> +                               enable-offset = <0x8>;
> +                               enable-mask = <0x1>;
> +                               divider-offset = <0x164>;
> +                               divider-width = <0x5>;
> +                               divider-shift = <0x0>;
> +                               clock-output-names = "ahbclk";
> +                       };
> +
> +                       sdioclk: sdioclk@1f2ac000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
> +                                       0x0 0x17000000 0x0 0x2000>;
> +                               reg-names = "csr-reg", "div-reg";
> +                               csr-offset = <0x0>;
> +                               csr-mask = <0x2>;
> +                               enable-offset = <0x8>;
> +                               enable-mask = <0x2>;
> +                               divider-offset = <0x178>;
> +                               divider-width = <0x8>;
> +                               divider-shift = <0x0>;
> +                               clock-output-names = "sdioclk";
> +                       };
> +
>                         qmlclk: qmlclk {
>                                 compatible = "apm,xgene-device-clock";
>                                 #clock-cells = <1>;
> @@ -533,6 +567,15 @@
>                         interrupts = <0x0 0x4f 0x4>;
>                 };
>
> +               mmc0: mmc@1c000000 {
> +                       compatible = "arasan,sdhci-4.9a";
> +                       reg = <0x0 0x1c000000 0x0 0x100>;
> +                       interrupts = <0x0 0x49 0x4>;
> +                       dma-coherent;
> +                       clock-names = "clk_xin", "clk_ahb";
> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> +               };
> +
>                 phy1: phy@1f21a000 {
>                         compatible = "apm,xgene-phy";
>                         reg = <0x0 0x1f21a000 0x0 0x100>;
> --
> 1.8.2.1
>
>

Any comments on this patch ?? I changed the dts node name as per EPAR and
Arnd comments.
-- 
Thanks,
with regards,
Suman Tripathi

--047d7b66f445f3c5bd0516fa17ba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgLDxicj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIE1heSAyMSwgMjAxNSBhdCAyOjEzIFBNLCBTdW1h
biBUcmlwYXRoaSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpzdHJpcGF0aGlA
YXBtLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnN0cmlwYXRoaUBhcG0uY29tPC9hPiZndDs8L3NwYW4+
IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5U
aGlzIHBhdGNoIGFkZHMgdGhlIGFyYXNhbiBtbWMgbm9kZXMgdG8gcmV1c2UgdGhlIG9mLWFyYXNh
bjxicj4NCmRyaXZlciBmb3IgQVBNIFgtR2VuZSBTb0MuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1i
eTogU3VtYW4gVHJpcGF0aGkgJmx0OzxhIGhyZWY9Im1haWx0bzpzdHJpcGF0aGlAYXBtLmNvbSI+
c3RyaXBhdGhpQGFwbS5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCi0tLTxicj4NCsKgYXJjaC9h
cm02NC9ib290L2R0cy9hcG0vYXBtLW11c3RhbmcuZHRzIHzCoCA0ICsrKzxicj4NCsKgYXJjaC9h
cm02NC9ib290L2R0cy9hcG0vYXBtLXN0b3JtLmR0c2nCoCB8IDQzICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKzxicj4NCsKgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCsp
PGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXBtL2FwbS1tdXN0
YW5nLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXBtL2FwbS1tdXN0YW5nLmR0czxicj4NCmlu
ZGV4IDgzNTc4ZTcuLjdhM2VhNzIgMTAwNjQ0PGJyPg0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9hcG0vYXBtLW11c3RhbmcuZHRzPGJyPg0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hcG0v
YXBtLW11c3RhbmcuZHRzPGJyPg0KQEAgLTUyLDMgKzUyLDcgQEA8YnI+DQrCoCZhbXA7eGdlbmV0
IHs8YnI+DQrCoCDCoCDCoCDCoCBzdGF0dXMgPSAmcXVvdDtvayZxdW90Ozs8YnI+DQrCoH07PGJy
Pg0KKzxicj4NCismYW1wO21tYzAgezxicj4NCivCoCDCoCDCoCDCoHN0YXR1cyA9ICZxdW90O29r
JnF1b3Q7Ozxicj4NCit9Ozxicj4NCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Fw
bS9hcG0tc3Rvcm0uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXBtL2FwbS1zdG9ybS5kdHNp
PGJyPg0KaW5kZXggYzhkM2UwZS4uOGUwM2VjZCAxMDA2NDQ8YnI+DQotLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2FwbS9hcG0tc3Rvcm0uZHRzaTxicj4NCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvYXBtL2FwbS1zdG9ybS5kdHNpPGJyPg0KQEAgLTE0NSw2ICsxNDUsNDAgQEA8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbG9jay1vdXRwdXQt
bmFtZXMgPSAmcXVvdDtzb2NwbGxkaXYyJnF1b3Q7Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIH07PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYWhiY2xrOiBhaGJjbGtAMWYyYWMwMDAgezxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbXBhdGlibGUgPSAmcXVvdDthcG0seGdl
bmUtZGV2aWNlLWNsb2NrJnF1b3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCNjbG9jay1jZWxscyA9ICZsdDsxJmd0Ozs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9ja3MgPSAmbHQ7JmFt
cDtzb2NwbGxkaXYyIDAmZ3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJlZyA9ICZsdDsweDAgMHgxZjJhYzAwMCAweDAgMHgxMDAwPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgMHgwIDB4MTcwMDAwMDAgMHgwIDB4MjAwMCZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVnLW5hbWVzID0gJnF1b3Q7Y3NyLXJlZyZx
dW90OywgJnF1b3Q7ZGl2LXJlZyZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjc3Itb2Zmc2V0ID0gJmx0OzB4MCZndDs7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY3NyLW1hc2sgPSAm
bHQ7MHgxJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBlbmFibGUtb2Zmc2V0ID0gJmx0OzB4OCZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW5hYmxlLW1hc2sgPSAmbHQ7MHgxJmd0
Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBk
aXZpZGVyLW9mZnNldCA9ICZsdDsweDE2NCZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGl2aWRlci13aWR0aCA9ICZsdDsweDUmZ3Q7Ozxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpdmlk
ZXItc2hpZnQgPSAmbHQ7MHgwJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9jay1vdXRwdXQtbmFtZXMgPSAmcXVvdDthaGJjbGsmcXVv
dDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTs8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2Rpb2Nsazogc2Rpb2Nsa0Ax
ZjJhYzAwMCB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY29tcGF0aWJsZSA9ICZxdW90O2FwbSx4Z2VuZS1kZXZpY2UtY2xvY2smcXVvdDs7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgI2Nsb2Nr
LWNlbGxzID0gJmx0OzEmZ3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNsb2NrcyA9ICZsdDsmYW1wO3NvY3BsbGRpdjIgMCZndDs7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVnID0gJmx0
OzB4MCAweDFmMmFjMDAwIDB4MCAweDEwMDA8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweDAgMHgxNzAwMDAwMCAweDAgMHgy
MDAwJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZWctbmFtZXMgPSAmcXVvdDtjc3ItcmVnJnF1b3Q7LCAmcXVvdDtkaXYtcmVnJnF1b3Q7
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNz
ci1vZmZzZXQgPSAmbHQ7MHgwJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjc3ItbWFzayA9ICZsdDsweDImZ3Q7Ozxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVuYWJsZS1vZmZzZXQgPSAm
bHQ7MHg4Jmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBlbmFibGUtbWFzayA9ICZsdDsweDImZ3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpdmlkZXItb2Zmc2V0ID0gJmx0OzB4MTc4
Jmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBkaXZpZGVyLXdpZHRoID0gJmx0OzB4OCZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGl2aWRlci1zaGlmdCA9ICZsdDsweDAmZ3Q7Ozxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb2Nr
LW91dHB1dC1uYW1lcyA9ICZxdW90O3NkaW9jbGsmcXVvdDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfTs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcW1sY2xrOiBxbWxjbGsgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbXBhdGlibGUgPSAmcXVvdDthcG0seGdlbmUt
ZGV2aWNlLWNsb2NrJnF1b3Q7Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICNjbG9jay1jZWxscyA9ICZsdDsxJmd0Ozs8YnI+DQpAQCAtNTMzLDYg
KzU2NywxNSBAQDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludGVy
cnVwdHMgPSAmbHQ7MHgwIDB4NGYgMHg0Jmd0Ozs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB9Ozxicj4NCjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1tYzA6IG1tY0AxYzAwMDAw
MCB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29tcGF0aWJsZSA9
ICZxdW90O2FyYXNhbixzZGhjaS00LjlhJnF1b3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJlZyA9ICZsdDsweDAgMHgxYzAwMDAwMCAweDAgMHgxMDAmZ3Q7Ozxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludGVycnVwdHMgPSAmbHQ7
MHgwIDB4NDkgMHg0Jmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBkbWEtY29oZXJlbnQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Y2xvY2stbmFtZXMgPSAmcXVvdDtjbGtfeGluJnF1b3Q7LCAmcXVvdDtjbGtfYWhiJnF1b3Q7Ozxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb2NrcyA9ICZsdDsmYW1w
O3NkaW9jbGsgMCZndDssICZsdDsmYW1wO2FoYmNsayAwJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9Ozxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwaHkxOiBw
aHlAMWYyMWEwMDAgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNv
bXBhdGlibGUgPSAmcXVvdDthcG0seGdlbmUtcGh5JnF1b3Q7Ozxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlZyA9ICZsdDsweDAgMHgxZjIxYTAwMCAweDAgMHgxMDAm
Z3Q7Ozxicj4NCi0tPGJyPg0KMS44LjIuMTxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48
YnI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+QW55IGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2ggPz8gSSBj
aGFuZ2VkIHRoZSBkdHMgbm9kZSBuYW1lIGFzIHBlciBFUEFSIGFuZCBBcm5kIGNvbW1lbnRzLjwv
ZGl2Pi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxk
aXY+VGhhbmtzLDwvZGl2PjxkaXY+d2l0aCByZWdhcmRzLDwvZGl2PlN1bWFuIFRyaXBhdGhpPC9k
aXY+PC9kaXY+DQo8L2Rpdj48L2Rpdj4NCg==
--047d7b66f445f3c5bd0516fa17ba--

--===============0713068372278960775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============0713068372278960775==--
