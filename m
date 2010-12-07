From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Mon, 6 Dec 2010 21:52:33 -0500
Message-ID: <AANLkTi=2gcr_5uSQtu+5_35xG4ZhsLRCwWCW+Me-QSLb@mail.gmail.com>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41511 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0LGCwl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 21:52:41 -0500
Received: by fxm20 with SMTP id 20so4905967fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Dec 2010 18:52:40 -0800 (PST)
In-Reply-To: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, njun@marvell.com, binw@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Sat, Dec 4, 2010 at 11:22 AM, Daniel Drake <dsd@laptop.org> wrote:
> Hi,
>
> The XO-1.5 laptop ships with an internal wifi adapter connected to th=
e
> SDIO bus (on a sdhci-pci host).
>
> We were experiencing a problem where initialization of this card
> sometimes failed (on low-level SD stuff, like setting voltage or
> reading CCCR). Also, when runtime PM was enabled, the card
> consistently fails to come back after it has been powered down.
>
> We believe this is due to a hardware bug with the wifi card. After SD
> power has been cut and restored, the card is left in inconsistent
> state. http://dev.laptop.org/ticket/10270#comment:4
>
> "According to a confidential Marvell AN, we should be asserting RESET
> externally after powering up the WLAN card. The Linux driver should
> assert WLAN_RESETn low for between 1 and 20 uS, about 1 mS after
> turning on power to the card"
>
> While other users of this wifi card have WLAN_RESETn permanently wire=
d
> low, OLPC has it wired to a GPIO. So we *can* do the above from the
> kernel, but its specific to this particular laptop.
>
> The question is: how?
> The actual code to do this is trivial, but where would we fit it into
> the kernel?

In marvell platfrom, we handle gpio related behavior via rfkill,
1. platfrom transfer gpio pin via platfrom data, so different platform
could have different gpio
2. rfkill block/unblock wifi/bt etc, to pull up/down gpio.
3. using rfkill to handle power saving mode

Is this handle you requirement.
We may plan to push rfkill, in order to support marvell wifi/bt etc.


>
>
> Ohad suggested that we look at the regulator subsystem. =A0After havi=
ng
> a look I think this would be a hack at best. The docs say:
>
> "The intention is to allow systems to dynamically control regulator p=
ower output
> in order to save power and prolong battery life. This applies to both=
 voltage
> regulators (where voltage output is controllable) and current sinks (=
where
> current limit is controllable)."
>
> And indeed, the requirement that you're regulating current or voltage
> comes all the way into the implementation.
>
> In this case we are not changing current or voltage, we are just
> asserting a specific signal to the card. So its messy from the start
> (I'd have to invent a list of supported voltages or something).
>
>
>
> Another option would be just to hack this into the kernel. Inside
> mmc_power_up we'd add something like the following:
>
> #ifdef CONFIG_OLPC
> if (machine_is_olpc())
> =A0 olpc_reset_gpio_fixup(host);
> #endif
>
> And olpc_reset_gpio_fixup() would check that we're running on XO-1.5,
> check that the host in question is the one where the wifi card is, an=
d
> do the GPIO twiddle.
>
>
> Another cleaner option (but perhaps OTT for just 1 user?) would be to
> add a notifier chain that is called at this point.
> Then we'd add a whole new "driver" in drivers/mmc somewhere that
> registers the appropriate notifier and handles this case.
>
>
> Thoughts? Other ideas?
>
> Thanks,
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
