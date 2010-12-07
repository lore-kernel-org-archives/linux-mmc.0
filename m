From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Tue, 7 Dec 2010 11:47:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012071145300.13430@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com> <AANLkTinFMMWSrvBQKpFNituHSG2cgUrg5d5-nF+cMe-q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57858 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab0LGSrW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 13:47:22 -0500
In-Reply-To: <AANLkTinFMMWSrvBQKpFNituHSG2cgUrg5d5-nF+cMe-q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, sawant@ti.com, linux-mmc@vger.kernel.org

Hello Madhusudhan,

On Tue, 7 Dec 2010, Chikkature Rajashekar, Madhusudhan wrote:

> Last I tested OFF mode was after Adrian's power saving series was merged. I
> tested it on Kevin PM branch then and it was functional on my omap3 board.
>
> I need to check on the latest commit.
> 
> Did you see this problem in suspend/resume path or the cpuidle path?

I noticed it on the CPUIdle path.


- Paul
