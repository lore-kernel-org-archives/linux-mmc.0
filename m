Return-Path: <SRS0=fUFB=3M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A52FC2D0DB
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jan 2020 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3460E24125
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jan 2020 10:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWKk4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:40:56 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWKk4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2020 05:40:56 -0500
Received: from localhost ([130.83.5.183]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis) id
 1M42zo-1iuZus3MFU-0007o1; Thu, 23 Jan 2020 11:40:50 +0100
Date:   Thu, 23 Jan 2020 11:40:47 +0100
From:   Tim Schumacher <tim@timakro.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        pher1989@hotmail.com
Subject: Re: Black screen while resuming a SDXC (UHS) card (_mmc_sd_resume)
Message-ID: <20200123104047.GA1254@impa>
References: <20190905200138.GA19037@impa.localdomain>
 <CAPDyKFqo-LecRE5R4T+vrGgNs83WFmQr84oaieEUTCjLFOLXoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqo-LecRE5R4T+vrGgNs83WFmQr84oaieEUTCjLFOLXoA@mail.gmail.com>
X-Provags-ID: V03:K1:YaR1agyNP4kdGQZh9BVroY6O+tgWL3523f5OjH0j4Gj4I4NNwcl
 FfWbhkcw96XnMkJfzfAujCBowxqD3QA1eQZ/t5T5gVmAM0VDvSnduEu+OG/M/0nuQMnXEIS
 Sa3tlVfhQv5IJl8tJWA7ajPsBIjE5TwR9Q0qAHV81oUfkEC85m4CJuJYVKSd+vVyiw/hLAP
 GHosxIZN3GQAsifGRwoAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:USqZWJ4TUUE=:dHwjDUn0OEtZxeyqgdKptw
 ytm9ElY7EY4OmpyKJ+WUF8UCsk+zSj/Lm7bqON1wCE3AddpWVMdWp6HMRhss1cBKXF36oNXur
 ECDyhPOVl5mAv+B9XXq70FchLSLh1vAB7JUARTGmAG2pMP46LVMdvZk7kpnVOMGiw/vfj5kQX
 dLwbqNNb70tolzH4s0jNjX8aLCoF4gjZnf0yLrswCqynDs1YJhAmkQbLdmPRoTJ5NItgxVTYf
 g1ZJvT98HmItuGCM2fnVUt3ZcwNUd2f5/VBYjtIbwHi6gyBoqN7brhTYbFORf1uco+GTKUnf6
 MA/KUqoGNmylG0WRO6YHwI0PNnGZUdAKeeMQD6KwaMsUQJz4hz5VIpJQkNFQtnc8WuYVVxY39
 NkOq/7hbzOsvrw2IErdb84dJZwGNHFfwRU8Z5oUifMJLAsOcJwXrWZOI/RXcCwtHM0uSxLum9
 Scn3ErRFlpyjmxnwerXO+wuUTxs7YJBnDmf6wyDEh8ErZe8xyfY4IiLEV4agFLlR/4gPGTqWx
 QDwU/etDtso5BQdZU2tGppFJhKHZ5rovXGZNznA1GXIA3ScBAQcVeYtRp6dt5JD0CIl0feSna
 TYzO6a25OzYkEZvaIALnj1KqSlrjMpA0P1q302oVk/dsAyU09F6dW0HlqKsHYbBC9IqhRRcrd
 iQVvktT2hdNkiWvBaA/sIo3dJGCH8MddYcEfxYxNfLIuyZ+LIyxa4t0F/3z0B2iVuZ0emoOEx
 rbnLzlfQI61mCQOh/WG/OfnLzXaKe/Xygp+nIpuZeqa6wegENlws22bbEqDPyJIQIzQ/CpEfy
 Jvl+zwReE10AN5J/UUARq9ghCyR5i4FK6+lcJDnwIsRzgfNEWc=
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2019-09-06, Ulf Hansson wrote:
> On Thu, 5 Sep 2019 at 22:01, Tim Schumacher <tim@timakro.de> wrote:
> >
> > Hi,
> >
> > I'm sending this old bug by mail since a lot of developers don't use
> > bugzilla.
> >
> > Original bug report on bugzilla by Pedro Rodrigues from 2019-01-30:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=202459
> >
> > > This bug can be found on a Lenovo Miix 320-10ICR
> > >
> > > When using a SDXC (UHS) card, the screen becomes black if
> > > _mmc_sd_resume() is called. After some investigation, I found that an
> > > UHS card uses 1.8 V for signalling while a normal SD card uses 3.3 V. By
> > > forcing the SDXC to use 3.3 V the black screen does not appear. It seems
> > > that during a _mmc_sd_resume function call, while claiming the host, an
> > > I2C resume function is called based on an existing supplier link between
> > > the I2C bus and the card device.  The problem is that if the signalling
> > > voltage is configured to 1.8 V, during the I2C resume call, the screen
> > > turns black.  I was able to fix this issue by setting the initial signal
> > > voltage (3.3 V) before suspending the card, so that when the card is
> > > resumed, the voltage is in the original state. To do this I added a
> > > function call to mmc_set_initial_signal_voltage() during mmc_power_off
> > > routine (drivers/mmc/core/core.c).  As I’m not an expert on Linux,  I’m
> > > posting the issue and possible solution so that it could be implemented
> > > on a future release.
> > >
> > > Please, share your thoughts :)
> >
> > I can't provide further insight but I'm interested if this is possibly
> > the cause for the general issues people are having with the SD card
> > reader on Lenovo Miix 320 devices.
> >
> > Those issues described in posts like
> >
> > https://vincent-ventures.com/2018/12/arch-linux-on-lenovo-ideapad-miix-320/
> > https://esc.sh/blog/linux-on-lenovo-miix-320/
> >
> > are (1) black screen when booting with an SD card installed and (2) when
> > inserting an SD card after booting it shows up but upon trying to access
> > it the screen turns black until the card is removed again.
> >
> > I can confirm (1) on my Lenovo Miix 320-10ICR with kernel version
> > 5.2.11. I can also confirm that only SDXC cards are affected, SD and
> > SDHC cards work as expected.
> 
> For the mmc community to help, you need to provide some kernel logs,
> output from lspci, figure out what mmc host driver that is being used,
> etc - in general collect more data. Then re-post the data to
> linux-mmc, me and a potential mmc host driver maintainer (if there is
> one). Yes, we can look into bugzilla as well, but first we need some
> more overall info in an email.
> 
> Most likely, if there is any response, you will be asked to test
> patches. So you need to be able build and boot a new kernel, but I
> guess you already know that part.
> 
> Kind regards
> Uffe
> 

Hi, I'm coming back to this issue now. The issue is still present in
kernel version 5.4.8.

Kernel logs from boot with SD card and black screen: https://termbin.com/outp
Kernel logs from boot without SD card: https://termbin.com/dc2y

I couldn't find anything conspicuous in there, the card is working as
expected. Only issue is the black screen (I'm doing these tests via SSH).

lspci output: https://termbin.com/x452

How do I figure out which mmc host driver is in use? I assume I'm
looking for one of these https://github.com/torvalds/linux/tree/master/drivers/mmc/host
I couldn't find anything like it in the kernel logs or from lsmod.

Please read the original bug report by Pedro Rodrigues quoted above.
He got to the technical core of the problem already and proposed a fix
I assume could be understood, sanity checked and implemented by a mmc
maintainer.

Regards
Tim
