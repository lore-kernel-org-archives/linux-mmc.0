From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v6 1/2] arm64: dts: Add the arasan sdhci nodes in
 apm-storm.dtsi.
Date: Fri, 8 May 2015 13:39:39 +0530
Message-ID: <CAOHikRDMqKo+c8CSkxAGaP8jOqB0aw9yFXvqxz_j6Di_sLciLA@mail.gmail.com>
References: <1430919731-9016-1-git-send-email-stripathi@apm.com>
 <1430919731-9016-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0700330639384436834=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1430919731-9016-2-git-send-email-stripathi@apm.com>
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

--===============0700330639384436834==
Content-Type: multipart/alternative; boundary=f46d043bdf9cbcbdad05158d8ce2

--f46d043bdf9cbcbdad05158d8ce2
Content-Type: text/plain; charset=UTF-8

On Wed, May 6, 2015 at 7:12 PM, Suman Tripathi <stripathi@apm.com> wrote:

> This patch adds the arasan sdhci nodes to reuse the of-arasan
> driver for APM X-Gene SoC.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43
> +++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts
> b/arch/arm64/boot/dts/apm/apm-mustang.dts
> index 83578e7..7ccd517 100644
> --- a/arch/arm64/boot/dts/apm/apm-mustang.dts
> +++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
> @@ -52,3 +52,7 @@
>  &xgenet {
>         status = "ok";
>  };
> +
> +&sdhci0 {
> +       status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index c8d3e0e..b5d2698 100644
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
> +               sdhci0: sdhci@1c000000 {
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
Any comments on this patch ??

-- 
Thanks,
with regards,
Suman Tripathi

--f46d043bdf9cbcbdad05158d8ce2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIFdlZCwgTWF5IDYsIDIwMTUgYXQgNzoxMiBQTSwgU3VtYW4gVHJp
cGF0aGkgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86c3RyaXBhdGhpQGFwbS5j
b20iIHRhcmdldD0iX2JsYW5rIj5zdHJpcGF0aGlAYXBtLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90
ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+VGhpcyBw
YXRjaCBhZGRzIHRoZSBhcmFzYW4gc2RoY2kgbm9kZXMgdG8gcmV1c2UgdGhlIG9mLWFyYXNhbjxi
cj4NCmRyaXZlciBmb3IgQVBNIFgtR2VuZSBTb0MuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTog
U3VtYW4gVHJpcGF0aGkgJmx0OzxhIGhyZWY9Im1haWx0bzpzdHJpcGF0aGlAYXBtLmNvbSI+c3Ry
aXBhdGhpQGFwbS5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCsKgYXJjaC9hcm02NC9ib290L2R0
cy9hcG0vYXBtLW11c3RhbmcuZHRzIHzCoCA0ICsrKzxicj4NCsKgYXJjaC9hcm02NC9ib290L2R0
cy9hcG0vYXBtLXN0b3JtLmR0c2nCoCB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKzxicj4NCsKgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspPGJyPg0KPGJyPg0K
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXBtL2FwbS1tdXN0YW5nLmR0cyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvYXBtL2FwbS1tdXN0YW5nLmR0czxicj4NCmluZGV4IDgzNTc4ZTcu
LjdjY2Q1MTcgMTAwNjQ0PGJyPg0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9hcG0vYXBtLW11
c3RhbmcuZHRzPGJyPg0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hcG0vYXBtLW11c3Rhbmcu
ZHRzPGJyPg0KQEAgLTUyLDMgKzUyLDcgQEA8YnI+DQrCoCZhbXA7eGdlbmV0IHs8YnI+DQrCoCDC
oCDCoCDCoCBzdGF0dXMgPSAmcXVvdDtvayZxdW90Ozs8YnI+DQrCoH07PGJyPg0KKzxicj4NCism
YW1wO3NkaGNpMCB7PGJyPg0KK8KgIMKgIMKgIMKgc3RhdHVzID0gJnF1b3Q7b2smcXVvdDs7PGJy
Pg0KK307PGJyPg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXBtL2FwbS1zdG9y
bS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9hcG0vYXBtLXN0b3JtLmR0c2k8YnI+DQppbmRl
eCBjOGQzZTBlLi5iNWQyNjk4IDEwMDY0NDxicj4NCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
YXBtL2FwbS1zdG9ybS5kdHNpPGJyPg0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hcG0vYXBt
LXN0b3JtLmR0c2k8YnI+DQpAQCAtMTQ1LDYgKzE0NSw0MCBAQDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNsb2NrLW91dHB1dC1uYW1lcyA9ICZx
dW90O3NvY3BsbGRpdjImcXVvdDs7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTs8YnI+DQo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBh
aGJjbGs6IGFoYmNsa0AxZjJhYzAwMCB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY29tcGF0aWJsZSA9ICZxdW90O2FwbSx4Z2VuZS1kZXZpY2Ut
Y2xvY2smcXVvdDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgI2Nsb2NrLWNlbGxzID0gJmx0OzEmZ3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb2NrcyA9ICZsdDsmYW1wO3NvY3BsbGRp
djIgMCZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmVnID0gJmx0OzB4MCAweDFmMmFjMDAwIDB4MCAweDEwMDA8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweDAgMHgx
NzAwMDAwMCAweDAgMHgyMDAwJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZWctbmFtZXMgPSAmcXVvdDtjc3ItcmVnJnF1b3Q7LCAmcXVv
dDtkaXYtcmVnJnF1b3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGNzci1vZmZzZXQgPSAmbHQ7MHgwJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjc3ItbWFzayA9ICZsdDsweDEmZ3Q7
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVu
YWJsZS1vZmZzZXQgPSAmbHQ7MHg4Jmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbmFibGUtbWFzayA9ICZsdDsweDEmZ3Q7Ozxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpdmlkZXItb2Zm
c2V0ID0gJmx0OzB4MTY0Jmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBkaXZpZGVyLXdpZHRoID0gJmx0OzB4NSZndDs7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGl2aWRlci1zaGlmdCA9
ICZsdDsweDAmZ3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNsb2NrLW91dHB1dC1uYW1lcyA9ICZxdW90O2FoYmNsayZxdW90Ozs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Ozxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZGlvY2xrOiBzZGlvY2xrQDFmMmFjMDAwIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb21w
YXRpYmxlID0gJnF1b3Q7YXBtLHhnZW5lLWRldmljZS1jbG9jayZxdW90Ozs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAjY2xvY2stY2VsbHMgPSAm
bHQ7MSZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY2xvY2tzID0gJmx0OyZhbXA7c29jcGxsZGl2MiAwJmd0Ozs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZWcgPSAmbHQ7MHgwIDB4MWYy
YWMwMDAgMHgwIDB4MTAwMDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4MCAweDE3MDAwMDAwIDB4MCAweDIwMDAmZ3Q7Ozxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlZy1u
YW1lcyA9ICZxdW90O2Nzci1yZWcmcXVvdDssICZxdW90O2Rpdi1yZWcmcXVvdDs7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY3NyLW9mZnNldCA9
ICZsdDsweDAmZ3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNzci1tYXNrID0gJmx0OzB4MiZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW5hYmxlLW9mZnNldCA9ICZsdDsweDgmZ3Q7
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVu
YWJsZS1tYXNrID0gJmx0OzB4MiZndDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZGl2aWRlci1vZmZzZXQgPSAmbHQ7MHgxNzgmZ3Q7Ozxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpdmlkZXIt
d2lkdGggPSAmbHQ7MHg4Jmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBkaXZpZGVyLXNoaWZ0ID0gJmx0OzB4MCZndDs7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2xvY2stb3V0cHV0LW5h
bWVzID0gJnF1b3Q7c2Rpb2NsayZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9Ozxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBxbWxjbGs6IHFtbGNsayB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgY29tcGF0aWJsZSA9ICZxdW90O2FwbSx4Z2VuZS1kZXZpY2UtY2xv
Y2smcXVvdDs7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgI2Nsb2NrLWNlbGxzID0gJmx0OzEmZ3Q7Ozxicj4NCkBAIC01MzMsNiArNTY3LDE1IEBA
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50ZXJydXB0cyA9ICZs
dDsweDAgMHg0ZiAweDQmZ3Q7Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH07PGJyPg0K
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2RoY2kwOiBzZGhjaUAxYzAwMDAwMCB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29tcGF0aWJsZSA9ICZxdW90
O2FyYXNhbixzZGhjaS00LjlhJnF1b3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJlZyA9ICZsdDsweDAgMHgxYzAwMDAwMCAweDAgMHgxMDAmZ3Q7Ozxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludGVycnVwdHMgPSAmbHQ7MHgwIDB4
NDkgMHg0Jmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbWEt
Y29oZXJlbnQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2xvY2st
bmFtZXMgPSAmcXVvdDtjbGtfeGluJnF1b3Q7LCAmcXVvdDtjbGtfYWhiJnF1b3Q7Ozxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb2NrcyA9ICZsdDsmYW1wO3NkaW9j
bGsgMCZndDssICZsdDsmYW1wO2FoYmNsayAwJmd0Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9Ozxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwaHkxOiBwaHlAMWYy
MWEwMDAgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbXBhdGli
bGUgPSAmcXVvdDthcG0seGdlbmUtcGh5JnF1b3Q7Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHJlZyA9ICZsdDsweDAgMHgxZjIxYTAwMCAweDAgMHgxMDAmZ3Q7Ozxi
cj4NCi0tPGJyPg0KMS44LjIuMTxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+QW55
IGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2ggPz88YnIgY2xlYXI9ImFsbCI+PGRpdj48YnI+PC9kaXY+
LS0gPGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj5U
aGFua3MsPC9kaXY+PGRpdj53aXRoIHJlZ2FyZHMsPC9kaXY+U3VtYW4gVHJpcGF0aGk8L2Rpdj48
L2Rpdj4NCjwvZGl2PjwvZGl2Pg0K
--f46d043bdf9cbcbdad05158d8ce2--

--===============0700330639384436834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============0700330639384436834==--
