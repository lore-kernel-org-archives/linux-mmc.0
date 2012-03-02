From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Fri, 2 Mar 2012 12:41:45 +0530
Message-ID: <CANfBPZ8Oypwqq2p3rcNpp5M8+XPHDmUxMRw2J5Jw5DdAKQj8cw@mail.gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com>
 <CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
 <4EFC6992.4020501@gmail.com> <CACTFLAMCoKfQbTe2RLTvi1_CH0nKzAOthAwrifNe2+F2sf3uPA@mail.gmail.com>
 <20120302001121.GE18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46440 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab2CBHMH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Mar 2012 02:12:07 -0500
Received: by mail-bk0-f47.google.com with SMTP id jg15so1818603bkc.34
        for <linux-mmc@vger.kernel.org>; Thu, 01 Mar 2012 23:12:05 -0800 (PST)
In-Reply-To: <20120302001121.GE18901@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>
Cc: Daniel Mack <zonque@gmail.com>, Rajendra Nayak <rnayak@ti.com>, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

+Chris queues all MMC patches including omap_hsmmc.
Ping ?


On Fri, Mar 2, 2012 at 5:41 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Daniel Mack <zonque@gmail.com> [120217 05:13]:
>> ping? Could anyone care for queueing this please?
>
> I suggest Rajendra queue up omap_hsmmc.c patches as he's already
> patching it.
>
> Regards,
>
> Tony
>
>
>> On Thu, Dec 29, 2011 at 2:22 PM, Daniel Mack <zonque@gmail.com> wrot=
e:
>> > On 12/23/2011 04:40 PM, T Krishnamoorthy, Balaji wrote:
>> >> On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> w=
rote:
>> >>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/om=
ap_hsmmc.c
>> >>> index 101cd31..8215ef9 100644
>> >>> --- a/drivers/mmc/host/omap_hsmmc.c
>> >>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> >>> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct=
 platform_device *pdev)
>> >>> =A0 =A0 =A0 =A0if (mmc_slot(host).vcc_aux_disable_is_sleep)
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_slot(host).no_off =3D 1;
>> >>>
>> >>> - =A0 =A0 =A0 mmc->f_min =A0 =A0 =A0=3D OMAP_MMC_MIN_CLOCK;
>> >>> - =A0 =A0 =A0 mmc->f_max =A0 =A0 =A0=3D OMAP_MMC_MAX_CLOCK;
>> >>> + =A0 =A0 =A0 mmc->f_min =3D OMAP_MMC_MIN_CLOCK;
>> >>
>> >> Stray change for f_min ?
>> >
>> > No, this was intended. The indentation doesn't make sense anymore =
when
>> > not grouped with the f_max assignment.
>> >
>> > Other than that, what is necessary to get this picked? Tony? :)
>> >
>> >
>> > Thanks,
>> > Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
