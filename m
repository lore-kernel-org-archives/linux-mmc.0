From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH V4 2/3] ARM: mmc: bcm281xx SDHCI driver
Date: Fri, 31 May 2013 17:17:36 -0700
Message-ID: <51A93DA0.3070909@broadcom.com>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
 <1369860607-25572-2-git-send-email-csd@broadcom.com>
 <87d2s7ceh0.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87d2s7ceh0.fsf@octavius.laptop.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-doc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Wei WANG <wei_wang@realsil.com.cn>, matt.porter@linaro.org, Kevin Liu <kliu5@marvell.com>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, csd_b@daudt.org, Viresh Kumar <viresh.kumar@linaro.org>, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, Bill Pemberton <wfp5p@virginia.edu>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@arm.linux.org.uk>, Anton Vorontsov <avorontsov@ru.mvista.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Rob Landley <rob@lan>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,
On 13-05-31 09:15 AM, Chris Ball wrote:
>
> Could you investigate replacing this section of code with a call to
> mmc_of_parse(), please?  It should be able to replace your parsing
> and handling of bus-width, cd-gpios, wp-gpios, and non-removable
> (other than the initialization quirks specific to your hardware).
>
> I'd like to avoid every driver having its own DT parsing.
> Thanks,
>
> - Chris.
I looked into it and it can replace just about everything that our own 
dt parsing code is doing. The only problem is with cd_gpio. If I call 
mmc_of_parse, then it will install its own irq handler for cd gpio, and 
our driver needs a different handler. the mmc irq handler can call a 
card_event callback, but that is already pointing to sdhci_card_event. 
So the only way I can use mmc_of_parse that I can see is by adding a 
flag to it to skip cd_gpio parsing which only this driver will then set 
to true. Any other ideas ?

  Thanks,
    csd
