From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 04/11] mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card
Date: Wed, 30 Oct 2019 18:24:28 +0100
Message-ID: <607E3AE4-65BF-4003-86BE-C70646D53D09@goldelico.com>
References: <cover.1571510481.git.hns@goldelico.com> <0887d84402f796d1e7361261b88ec6057fbb0065.1571510481.git.hns@goldelico.com> <CAPDyKFp3EjTuCTj+HXhxf+Ssti0hW8eMDR-NrGYWDWSDmQz6Lw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp3EjTuCTj+HXhxf+Ssti0hW8eMDR-NrGYWDWSDmQz6Lw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

> Am 30.10.2019 um 16:51 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
>> +
>> +               np =3D of_get_compatible_child(np, "ti,wl1251");
>> +               if (np) {
>> +                       /*
>> +                        * We have TI wl1251 attached to MMC3. Pass =
this information to
>> +                        * SDIO core because it can't be probed by =
normal methods.
>> +                        */
>> +
>> +                       dev_info(host->dev, "found wl1251\n");
>> +                       card->quirks |=3D MMC_QUIRK_NONSTD_SDIO;
>> +                       card->cccr.wide_bus =3D 1;
>> +                       card->cis.vendor =3D 0x104c;
>> +                       card->cis.device =3D 0x9066;
>> +                       card->cis.blksize =3D 512;
>> +                       card->cis.max_dtr =3D 24000000;
>> +                       card->ocr =3D 0x80;
>=20
> These things should really be figured out by the mmc core during SDIO
> card initialization itself, not via the host ops ->init_card()
> callback. That is just poor hack, which in the long run should go
> away.

Yes, I agree.

But I am just the poor guy who is trying to fix really broken code with
as low effort as possible.

I don't even have a significant clue what this code is exactly doing and =
what
the magic values mean. They were setup by pandora_wl1251_init_card() in =
the
same way so that I have just moved the code here and make it called in =
(almost)
the same situation.

> Moreover, I think we should add a subnode to the host node in the DT,
> to describe the embedded SDIO card, rather than parsing the subnode
> for the SDIO func - as that seems wrong to me.

You mean a second subnode?

The wl1251 is the child node of the mmc node and describes the SDIO =
card.
We just check if it is a wl1251 or e.g. wl1837 or something else or even
no child.

> To add a subnode for the SDIO card, we already have a binding that I
> think we should extend. Please have a look at
> Documentation/devicetree/bindings/mmc/mmc-card.txt.
>=20
> If you want an example of how to implement this for your case, do a
> git grep "broken-hpi" in the driver/mmc/core/, I think it will tell
> you more of what I have in mind.

So while I agree that it should be improved in the long run, we should
IMHO fix the hack first (broken since v4.9!), even if it remains a hack
for now. Improving this part seems to be quite independent and focussed
on the mmc subsystem, while the other patches involve other subsystems.

Maybe should we make a REVISIT note in the code? Or add something to
the commit message about the idea how it should be done right?

>=20
>> +                       of_node_put(np);
>> +               }
>> +       }
>> }
>>=20
>> static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int =
enable)
>> --
>> 2.19.1
>>=20
>=20
> Kind regards
> Uffe


BR and thanks,
Nikolaus
