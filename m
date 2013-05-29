From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 1/3] mmc: Add size for caller in init+register
Date: Wed, 29 May 2013 16:25:29 +0200
Message-ID: <CAPDyKFqQCWdtwOVS2qoD0_k6ZW9NU=30kjEd4mQUesecmutqpg@mail.gmail.com>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
 <CAPDyKFoPO0KTfW_i1EP8urSUT+U8yEaafrE2HdN2mmEkYCZm-w@mail.gmail.com>
 <201305291619.28396.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201305291619.28396.arnd@arndb.de>
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
Cc: linux-doc@vger.kernel.org, Christian Daudt <csd@broadcom.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Wei WANG <wei_wang@realsil.com.cn>, matt.porter@linaro.org, Kevin Liu <kliu5@marvell.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, csd_b@daudt.org, Viresh Kumar <viresh.kumar@linaro.org>, Chris Ball <cjb@laptop.org>, plagnioj@jcrosoft.com, Sascha Hauer <s.hauer@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Bill Pemberton <wfp5p@virginia.edu>, Haojian Zhuang <haojian.zhuang@gmail.com>, Stephen Warren <swarren@nvidia.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroche>
List-Id: linux-mmc@vger.kernel.org

On 29 May 2013 16:19, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 29 May 2013, Ulf Hansson wrote:
>> > diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
>> > index 1210ed1..ed4a85d 100644
>> > --- a/drivers/mmc/host/sdhci-pltfm.h
>> > +++ b/drivers/mmc/host/sdhci-pltfm.h
>> > @@ -27,6 +27,8 @@ struct sdhci_pltfm_host {
>> >         /* migrate from sdhci_of_host */
>> >         unsigned int clock;
>> >         u16 xfer_mode_shadow;
>> > +
>> > +       unsigned long private[0] ____cacheline_aligned;
>>
>> Why do you need this to be "____cacheline_aligned"?
>
> This is common practice for additional members in data structures
> like this. The reason is that we append a structure which
> may have larger alignment requirements than 'unsigned long'.
>
> The kmalloc function generally returns a cache line aligned
> object, so this provides the same alignment that we get
> with a separate allocation.
>
>         Arnd
>

Arnd, thanks for the explanation!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
