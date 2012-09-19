From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
Date: Wed, 19 Sep 2012 12:49:50 +0200
Message-ID: <2908357.YMzdc5AO51@amdc1227>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1907099.4JSZthrgh2@amdc1227> <m3627aguhl.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57718 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab2ISKt6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 06:49:58 -0400
In-reply-to: <m3627aguhl.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, jy0922.shim@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

hi,

On Wednesday 19 of September 2012 06:47:02 Chris Ball wrote:
> Hi,
> 
> On Wed, Sep 19 2012, Tomasz Figa wrote:
> > We could just check if the regulator provides the capability to change
> > the voltage.
> > 
> > I don't see any direct way of querying the regulator for provided
> > capabilities (correct me if I'm just blind), but calling
> > regulator_count_voltages() on the regulator and checking if the
> > returned
> > value is 1 should be enough to assume that the regulator is fixed.
> 
> Sounds good, I agree.  Are you able to test that the obvious patch below
> works on your fixed-regulator board?

Yes. I will report the result as soon as I test it.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center

