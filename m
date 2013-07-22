From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] dmaengine: add dma_get_slave_sg_limits()
Date: Mon, 22 Jul 2013 16:45:51 -0500
Message-ID: <51EDA80F.7060606@ti.com>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
	<1374166001-31340-2-git-send-email-joelf@ti.com>
	<20130718161658.GW16653@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130718161658.GW16653-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Mark Jackson <mpfj-list-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-k>
List-Id: linux-mmc@vger.kernel.org

On 07/18/2013 11:16 AM, Vinod Koul wrote:> On Thu, Jul 18, 2013 at
11:46:39AM -0500, Joel Fernandes wrote:
>> From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
>>
>> Add a dmaengine API to retrieve slave SG transfer limits.
>>
>> The API is optionally implemented by dmaengine drivers and when
>> unimplemented will return a NULL pointer. A client driver using
>> this API provides the required dma channel, address width, and
>> burst size of the transfer. dma_get_slave_sg_limits() returns an
>> SG limits structure with the maximum number and size of SG segments
>> that the given channel can handle.
> Hi Joel,
>
> I have already resurrected this and generalized the API to get the slave
> capablities.
> https://lkml.org/lkml/2013/7/15/147

Hi Vinod,

get_caps and get_sg_limits are 2 different things, looks like this was
already discussed earlier, and this patch series is a separate API that
adds support for SG limits.

Infact, you can already see here that he changed the name of the
function from caps to dma_get_slave_sg_limits:
http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2013-March/026601.html

Considering this, what is the way forward? Can this patch series be
merged as it is a different API as discussed above?

Summarizing:
* get_caps API cannot be used for this same purpose, as get_caps is done
_before_ the DMA channel can be configured from what it looks like:
* get_sg_limits, on the other hand is supposed to already have the
parameters required for configuring the DMA channel before hand.

Are there any other changes to the get_sg_limits series you would like
before it can be applied? Any other suggestions?

Thanks,

-Joel
