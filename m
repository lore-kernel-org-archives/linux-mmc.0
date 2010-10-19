From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Tue, 19 Oct 2010 17:17:40 +0200
Message-ID: <4CBDB694.4000209@eukrea.com>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com> <20101019150743.GA26784@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 30.mail-out.ovh.net ([213.186.62.213]:33084 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753355Ab0JSPRo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2010 11:17:44 -0400
In-Reply-To: <20101019150743.GA26784@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, r65037@freescale.com, shawn.gsc@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

Le 19/10/2010 17:07, Wolfram Sang a =E9crit :
> On Tue, Oct 19, 2010 at 02:49:01PM +0200, Eric B=E9nard wrote:
>> this patch fix timeout problems on i.MX51 as suggested by
>> Richard Zhu.
>> more tests are needed to check if this quirk can be removed
>> for i.MX25 and 35.
>
> Didn't you have such boards?

I do have, but I can't do the tests until next week because of other pr=
iorities.

Eric
