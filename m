From: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Subject: Re: [PATCH V5 1/3] SDHCI: S3C: Use generic clock names for sdhci bus
 clock options
Date: Mon, 31 Oct 2011 09:52:41 +0530
Message-ID: <CAPs=JDentx5BMfT4JYxSUpdQqKveAVMcJZk_TAatEwSoLDHUTA@mail.gmail.com>
References: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
	<1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
	<m2obx34j81.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43190 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1JaEWm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2011 00:22:42 -0400
In-Reply-To: <m2obx34j81.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Rajeshwari Shinde <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org

Hi Chris,

Thank you for your comment will modify and resend the patches.

Regards,
Rajeshwari Shinde.

On Thu, Oct 27, 2011 at 1:29 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Rajeshwari, Kukjin,
>
> On Fri, Oct 14 2011, Rajeshwari Shinde wrote:
>> This patch modifies the driver to stop depending on the clock names
>> being passed from the platform and switch over to bus clock lookup
>> using generic clock names.
>>
>> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
>> ---
>> =A0drivers/mmc/host/sdhci-s3c.c | =A0 =A06 ++----
>> =A01 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s=
3c.c
>> index 82709b6..a5fde87 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -435,14 +435,12 @@ static int __devinit sdhci_s3c_probe(struct pl=
atform_device *pdev)
>>
>> =A0 =A0 =A0 for (clks =3D 0, ptr =3D 0; ptr < MAX_BUS_CLK; ptr++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clk *clk;
>> - =A0 =A0 =A0 =A0 =A0 =A0 char *name =3D pdata->clocks[ptr];
>> + =A0 =A0 =A0 =A0 =A0 =A0 char name[14];
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (name =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sprintf(name, "mmc_busclk.%d", ptr);
>
> Let's use snprintf() here instead -- it's better to have fewer uses o=
f
> sprintf() to audit.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D clk_get(dev, name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(clk)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to ge=
t clock %s\n", name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
