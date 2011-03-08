From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: fix CONFIG_MMC_UNSAFE_RESUME regression
Date: Wed, 9 Mar 2011 00:20:58 +0200
Message-ID: <AANLkTi=_12e-fVudOAFedvW7x_PsRSAByOTDVwxMFbJ6@mail.gmail.com>
References: <1299619922-22220-1-git-send-email-ohad@wizery.com> <m3hbbdp97h.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64277 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab1CHWVS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 17:21:18 -0500
Received: by iwn34 with SMTP id 34so5277661iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 14:21:18 -0800 (PST)
In-Reply-To: <m3hbbdp97h.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>, Maxim Levitsky <maximlevitsky@gmail.com>, stable@kernel.org

On Tue, Mar 8, 2011 at 11:56 PM, Chris Ball <cjb@laptop.org> wrote:
> I have removed the stable@ tag, because the patch causing this
> regression was introduced in .38-rc1 -- it has not been part of
> any released kernel. =A0So, as long as we fix it before .38 releases
> in a week, there's no need to involve stable@.

Thanks, Chris.

I misread git describe; v2.6.37-3748-g30201e7 is of course post-2.6.37 =
material.
