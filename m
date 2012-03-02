From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device tree support
Date: Fri, 02 Mar 2012 15:40:05 -0500
Message-ID: <m2ty26n3dm.fsf@bob.laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
	<003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
	<m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com>
	<m239abgc32.fsf@bob.laptop.org>
	<00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
	<m2vcn0496y.fsf@bob.laptop.org> <20120222125823.GA14463@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120222125823.GA14463@sirena.org.uk> (Mark Brown's message of
	"Wed, 22 Feb 2012 12:58:23 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 22 2012, Mark Brown wrote:
> On Tue, Feb 21, 2012 at 08:17:41AM -0500, Chris Ball wrote:
>
>> Pushed to mmc-next, thanks.  (I'm expecting that you'll do the merge
>> to Linus.)
>
> I've been sending patches adding runtime PM support to this driver for a
> while with no response - are there any issues with those?

I don't have s3c hardware, so I've been waiting for a Tested-by or ACK
from someone who does -- Kukjin, any objection if I take this into
mmc-next with a plan to merge it, to provoke some testing?  Is it
possible for you to test/review the patch?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
