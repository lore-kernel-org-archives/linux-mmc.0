From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch] sdhci: correct f_min in sd 3.0
Date: Tue, 28 Sep 2010 00:58:51 -0400
Message-ID: <AANLkTikwUawcFJpRVqQoNqUEDv4a-uLDt2qYnSqf5end@mail.gmail.com>
References: <8C0FC31B-681F-4541-AD64-43578FC926F6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60384 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab0I1E6w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 00:58:52 -0400
Received: by iwn5 with SMTP id 5so5495236iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2010 21:58:51 -0700 (PDT)
In-Reply-To: <8C0FC31B-681F-4541-AD64-43578FC926F6@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zgao6@marvell.com>

On Tue, Sep 28, 2010 at 12:05 AM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> The code snippet
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (div =3D 2; div < SDHC=
I_MAX_DIV_SPEC_300; div +=3D 2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((hos=
t->max_clk / div) <=3D clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 break;
>
> is not correct. =A0In sdio 3.0 the value is not a power of 2 for the =
divider but the value to be divided down-- all the bits count

That's the reason using div +=3D 2 instead of div *=3D 2

> 2) 10-bit Divided Clock
> Host Controller Version 3.00 supports this mandatory mode instead of =
the
> 8-bit Divided Clock Mode. =A0The length of the divider is extended to=
 10 bits and all
> divider values shall be supported.
> 3FFh =A0 =A01/2046 =A0Divided Clock
>
> Philip
>
> Hi Zhangfei,
>
> On Sat, Sep 25, 2010 at 12:23:33AM -0400, zhangfei gao wrote:
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Mon, 20 Sep 2010 15:15:18 -0400
>> Subject: [PATCH] sdhci: correct f_min in sd 3.0
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 =A08 +++++---
>> =A0drivers/mmc/host/sdhci.h | =A0 =A03 +++
>> =A02 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 5928b0a..829e78a 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1007,14 +1007,14 @@ static void sdhci_set_clock(struct sdhci_hos=
t *host, unsigned int clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->max_clk <=3D clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (div =3D 2; div < 2046=
; div +=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (div =3D 2; div < SDHC=
I_MAX_DIV_SPEC_300; div +=3D 2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((hos=
t->max_clk / div) <=3D clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Version 2.00 divisors must be a power=
 of 2. */
>> - =A0 =A0 =A0 =A0 =A0 =A0 for (div =3D 1; div < 256; div *=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (div =3D 1; div < SDHCI_MAX_DIV_SPEC_2=
00; div *=3D 2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->max_clk / div=
) <=3D clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> @@ -1836,8 +1836,10 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 mmc->ops =3D &sdhci_ops;
>> =A0 =A0 =A0 if (host->ops->get_min_clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->ops->get_min_clock(=
host);
>> + =A0 =A0 else if (host->version >=3D SDHCI_SPEC_300)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / SDHCI_MAX_D=
IV_SPEC_300;
>> =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / 256;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / SDHCI_MAX_D=
IV_SPEC_200;
>> =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
>> =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index ae28a31..d35fb3d 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -185,6 +185,9 @@
>> =A0#define =A0 SDHCI_SPEC_200 =A0 =A0 1
>> =A0#define =A0 SDHCI_SPEC_300 =A0 =A0 2
>>
>> +#define =A0 =A0 =A0SDHCI_MAX_DIV_SPEC_200 =A0256
>> +#define =A0 =A0 =A0SDHCI_MAX_DIV_SPEC_300 =A02046
>> +
>> =A0struct sdhci_ops;
>>
>> =A0struct sdhci_host {
>
> Thanks very much, I've applied this to mmc-next now.
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
