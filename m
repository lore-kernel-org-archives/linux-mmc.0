From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Date: Wed, 18 Sep 2019 06:47:34 -0400
Message-ID: <20190918104734.GA3320@people.danlj.org>
References: <cover.1568184581.git.benchuanggli@gmail.com>
 <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

I see that the first four patches made it into Linus's kernel
yesterday. Is there any chance of this final patch that actually
enables the hardware making it into another pull request still
intended for 5.4?  Waiting on additional acked-by on Ben's work
addressing all the review comments?

Thanks.

On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add support for the GL9750 and GL9755 chipsets.
> 
> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> tuning flow for GL9750.
