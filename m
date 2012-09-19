From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
Date: Wed, 19 Sep 2012 12:13:14 +0200
Message-ID: <1587150.uFGRdL0s8e@amdc1227>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1346748609-11115-2-git-send-email-t.figa@samsung.com>
 <m38vc6k1qu.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <m38vc6k1qu.fsf@pullcord.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, jy0922.shim@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Wednesday 19 of September 2012 01:42:01 Chris Ball wrote:
> On Tue, Sep 04 2012, Tomasz Figa wrote:
> > Some boards use fixed voltage regulator for vmmc supply (e.g. for eMMC
> > memories). MMC_CAP2_BROKEN_VOLTAGE must be enabled for them to operate
> > correctly.
>>
> Is there a reason we can't make this a property on the regulator instead?

Is there a reason we can't make this a property of the mmc subsystem? ;)

Now, seriously, could you elaborate on this a bit more? Do you mean that a 
regulator should provide a dummy set voltage operation that would accept 
any voltage?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
