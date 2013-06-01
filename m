From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V4 2/3] ARM: mmc: bcm281xx SDHCI driver
Date: Sat, 1 Jun 2013 22:13:47 +0200
Message-ID: <201306012213.47386.arnd@arndb.de>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
 <87d2s7ceh0.fsf@octavius.laptop.org> <51A93DA0.3070909@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51A93DA0.3070909-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jerry Huang <Chang-Ming.Huang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Liu <kliu5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Saturday 01 June 2013, Christian Daudt wrote:
> I looked into it and it can replace just about everything that our own 
> dt parsing code is doing. The only problem is with cd_gpio. If I call 
> mmc_of_parse, then it will install its own irq handler for cd gpio, and 
> our driver needs a different handler. the mmc irq handler can call a 
> card_event callback, but that is already pointing to sdhci_card_event. 
> So the only way I can use mmc_of_parse that I can see is by adding a 
> flag to it to skip cd_gpio parsing which only this driver will then set 
> to true. Any other ideas ?

Can't you add a callback handler into sdhci_card_event that can call
a platform specific function?

	Arnd
