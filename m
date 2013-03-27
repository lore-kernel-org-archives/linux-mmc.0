From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v6 3/5] mmc: davinci_mmc: add DT support
Date: Wed, 27 Mar 2013 17:46:12 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4A9FC@DBDE01.ent.ti.com>
References: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
	<201303201326.09265.arnd@arndb.de>
	<A73F36158E33644199EB82C5EC81C7BC3EA4A96A@DBDE01.ent.ti.com>
	<201303271043.51265.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <201303271043.51265.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 27, 2013 at 16:13:51, Arnd Bergmann wrote:
> On Wednesday 27 March 2013, Manjunathappa, Prakash wrote:
> > On Wed, Mar 20, 2013 at 18:56:09, Arnd Bergmann wrote:
> > > On Wednesday 20 March 2013, Manjunathappa, Prakash wrote:
> > > > Adds device tree support for davinci_mmc. Also add binding documentation.
> > > > As of now in non-dma PIO mode and without GPIO card_detect/write_protect
> > > > option because of dependencies on EDMA and GPIO module DT support.
> > > 
> > > Shouldn't the binding at least specify the names for the DMA channels?
> > > It's fine if the driver works without those, but I think there is no
> > > strict dependency here: If dma_request_slave_channel does not find
> > > a channel, the driver can just continue in PIO mode, and as soon
> > > as the EDMA driver is merged, it will work with DMA.
> > 
> > In that case, don't I have to add support for it in driver also using
> > dma_request_slave_channel_compat? As we do not have edma support yet on
> > da850, I will not be able to test it.
> 
> The code is independent of the binding in this case. If you already know
> that the hardware supports DMA channels and you will add support in the
> code later, I would recommend writing up the binding the way it should
> be used.
> 

Ok I will add support for DMA bindings with a note saying "not tested dma capability via DT". 

Thanks,
Prakash
