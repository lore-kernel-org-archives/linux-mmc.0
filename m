From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 1/3] MMC: OMAP: HSMMC: Remove lazy_disable
Date: Thu, 23 Jun 2011 18:01:46 +0530
Message-ID: <BANLkTikbFbQyXkSyETd2s05q0pNLPq2f3g@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-2-git-send-email-balajitk@ti.com>
	<87k4cdrace.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87k4cdrace.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, "S, Venkatraman" <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 22, 2011 at 11:56 PM, Kevin Hilman <khilman@ti.com> wrote:
> Balaji T K <balajitk@ti.com> writes:
>
>> lazy_disable framework in OMAP HSMMC manages multiple low power stat=
es
>> and Card is powered off after inactivity time of 8 seconds.
>> Based on previous discussion on the list Card power(regulator)
>
> needs some punctuation for readability.

OK

>
>> handling (when to power OFF/ON) should ideally be handled by core la=
yer.
>
> So are you working on the core layer replacement for this? =A0If not,=
 is
> there a plan or owner for this?

Venkat and myself are planing to start on this for MMC and SD.
Some partial work has already been done for SDIO,
need to consolidate this for all three of them.

>
>> Remove usage of lazy disable to allow core layer _only_ to handle ca=
rd power.
>> With the removal of lazy disable framework, MMC regulators
>> are left ON until MMC_POWER_OFF via set_ios.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>
> [...]
>
>> @@ -2080,10 +1848,7 @@ static int __init omap_hsmmc_probe(struct pla=
tform_device *pdev)
>> =A0 =A0 =A0 platform_set_drvdata(pdev, host);
>> =A0 =A0 =A0 INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect)=
;
>>
>> - =A0 =A0 if (mmc_slot(host).power_saving)
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->ops =A0 =A0 =A0 =A0=3D &omap_hsmmc_ps=
_ops;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->ops =A0 =A0 =A0 =A0=3D &omap_hsmmc_op=
s;
>> + =A0 =A0 mmc->ops =A0 =A0 =A0 =A0=3D &omap_hsmmc_ops;
>
> I guess the _ps_ops struct is now completely unused so should probabl=
y
> be removed in this patch also.

done
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
