From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
Date: Sat, 16 Apr 2011 04:07:59 -0500
Message-ID: <BANLkTimUrvnkg5dxiSh6cmToR_QTpYtnyw@mail.gmail.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<1302863942-1774-2-git-send-email-arindam.nath@amd.com>
	<BANLkTimZGonC+D0czjiY4i7pFFW=upj_qw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB443FB6@SAUSEXMBP01.amd.com>
	<BANLkTimEKQceSiuL=dX2yhMw+MLu7BzLvQ@mail.gmail.com>
	<BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
	<BANLkTikoAWEMGOAHrxJT4jNknVFtyuhdqw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB44434B@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:60692 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1DPJID convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 05:08:03 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3G96Bb8024673
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 05:06:11 -0400 (EDT)
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3G96AiO024666
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 05:06:11 -0400 (EDT)
Received: by wwk4 with SMTP id 4so349941wwk.3
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 02:07:59 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB44434B@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Apr 16, 2011 at 12:25 AM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
> Hi Andrei,
>
> I saw in one of the community threads that you also have a patch ready for supporting Auto CMD23 for SDHCI. Can you share the same with us? I would like to take a look at your patch first before deciding whether it would make sense for controllers which comply with Host Controller Spec v3.00.
>

Will send updated patch set in a few. You and Subhash are on the Cc.
Once again, the Auto-CMD23 is completely untested. I would be
extremely grateful if you can verify it.
Is there any kind of error injection mechanism you guys use to verify
the error paths for Auto 12/23?

By the way -

+       /* If the host can perform ADMA operation, we reset SDMA flag */
+       if (host->flags & SDHCI_USE_ADMA)
+               host->flags &= ~SDHCI_USE_SDMA;

This seems completely unnecessary, as the code already prefers ADMA to
SDMA. What do you think?

A
