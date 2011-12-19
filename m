From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Mon, 19 Dec 2011 11:22:52 +0200
Message-ID: <CAK=Wgba2y6xq_GxR3KFnj+rHJd0o3wLD6e_sGMVsqAfnZ3jNYw@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
 <WC20111118100011.2902A2@terrafix.co.uk> <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
 <WC20111129111750.470087@terrafix.co.uk> <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
 <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
 <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
 <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
 <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com> <CAK=WgbaKFhknaDVEbPjmcWGL-F_DiYG0t1t-cB-sGWHPCOBErA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58919 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1LSJXO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 04:23:14 -0500
Received: by pbdu13 with SMTP id u13so1757458pbd.19
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2011 01:23:14 -0800 (PST)
In-Reply-To: <CAK=WgbaKFhknaDVEbPjmcWGL-F_DiYG0t1t-cB-sGWHPCOBErA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Neil Brown <neilb@suse.de>, Bing Zhao <bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>

On Mon, Dec 19, 2011 at 11:10 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> (it seems there are a few different hw revisions of it, some
> of which do require toggling the reset pin before sending another init
> sequence)

(it might just be different setups and not really different hw
revisions of the 8686)
