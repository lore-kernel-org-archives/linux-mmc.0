From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH V4 2/3] ARM: mmc: bcm281xx SDHCI driver
Date: Tue, 4 Jun 2013 07:19:05 -0700
Message-ID: <51ADF759.9000607@broadcom.com>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
 <87d2s7ceh0.fsf@octavius.laptop.org> <51A93DA0.3070909@broadcom.com>
 <201306012213.47386.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201306012213.47386.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Wei WANG <wei_wang@realsil.com.cn>, matt.porter@linaro.org, Kevin Liu <kliu5@marvell.com>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, csd_b@daudt.org, Viresh Kumar <viresh.kumar@linaro.org>, Chris Ball <cjb@laptop.org>, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, Bill Pemberton <wfp5p@virginia.edu>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@arm.linux.org.uk>, Anton Vorontsov <avorontsov@ru.mvista.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Rob Landley <rob@land>
List-Id: linux-mmc@vger.kernel.org

On 13-06-01 01:13 PM, Arnd Bergmann wrote:
> On Saturday 01 June 2013, Christian Daudt wrote:
>> I looked into it and it can replace just about everything that our own
>> dt parsing code is doing. The only problem is with cd_gpio. If I call
>> mmc_of_parse, then it will install its own irq handler for cd gpio, and
>> our driver needs a different handler. the mmc irq handler can call a
>> card_event callback, but that is already pointing to sdhci_card_event.
>> So the only way I can use mmc_of_parse that I can see is by adding a
>> flag to it to skip cd_gpio parsing which only this driver will then set
>> to true. Any other ideas ?
> Can't you add a callback handler into sdhci_card_event that can call
> a platform specific function?
>
>
I can add another layer of callbacks. I have to first check if I can 
rework our driver to fit into this callback model. I'll update this when 
I've tried it.

  thanks,
    csd
