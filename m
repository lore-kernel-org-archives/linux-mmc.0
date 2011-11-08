From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Tue, 8 Nov 2011 20:53:58 +0530
Message-ID: <CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
	<1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
	<20111107211726.GC28491@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20111107211726.GC28491@ponder.secretlab.ca>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Hi Grant,

On 8 November 2011 02:47, Grant Likely <grant.likely@secretlab.ca> wrot=
e:
> On Thu, Nov 03, 2011 at 02:06:03AM +0530, Thomas Abraham wrote:
>> Add device tree based discovery support for Samsung's sdhci controll=
er
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> +Example:
>> + =A0 =A0 sdhci@12530000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "samsung,exynos4210-sdhci";
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x12530000 0x100>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <139>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 samsung,sdhci-bus-width =3D <4>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 linux,mmc_cap_4_bit_data;
>
> Following on from my reply on patch 5, this is an example of exactly
> what I'm talking about. =A0This node both sets bus-width to '4', and
> sets the 4_bit_data flag. =A0Don't you think that the driver would be
> smart enough to set the 4_bit_data flag when the bus width was set to
> 4?

Yes, that is true. I will modify the driver based on your comments and
resubmit this patch.

Thanks for your comments.

Regards,
Thomas.

>
> g.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
