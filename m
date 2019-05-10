From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH 09/16] mmc: sdhci-xenon: use new match_string()
 helper/macro
Date: Fri, 10 May 2019 09:13:26 +0000
Message-ID: <31be52eb1a1abbc99a24729f5c65619235cb201f.camel@analog.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
 <20190508112842.11654-11-alexandru.ardelean@analog.com>
 <20190508122010.GC21059@kadam>
 <2ec6812d6bf2f33860c7c816c641167a31eb2ed6.camel@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2ec6812d6bf2f33860c7c816c641167a31eb2ed6.camel@analog.com>
Content-Language: en-US
Content-ID: <BB59C46108248B4E9B7153CD2DF23B7C@analog.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, linux-gpio@vger.kernel.or
List-Id: linux-mmc@vger.kernel.org

On Wed, 2019-05-08 at 16:26 +0300, Alexandru Ardelean wrote:
> On Wed, 2019-05-08 at 15:20 +0300, Dan Carpenter wrote:
> > 
> > 
> > On Wed, May 08, 2019 at 02:28:35PM +0300, Alexandru Ardelean wrote:
> > > -static const char * const phy_types[] = {
> > > -     "emmc 5.0 phy",
> > > -     "emmc 5.1 phy"
> > > -};
> > > -
> > >  enum xenon_phy_type_enum {
> > >       EMMC_5_0_PHY,
> > >       EMMC_5_1_PHY,
> > >       NR_PHY_TYPES
> > 
> > There is no need for NR_PHY_TYPES now so you could remove that as well.
> > 
> 
> I thought the same.
> The only reason to keep NR_PHY_TYPES, is for potential future patches,
> where it would be just 1 addition
> 
>  enum xenon_phy_type_enum {
>       EMMC_5_0_PHY,
>       EMMC_5_1_PHY,
> +      EMMC_5_2_PHY,
>       NR_PHY_TYPES
>   }
> 
> Depending on style/preference of how to do enums (allow comma on last
> enum
> or not allow comma on last enum value), adding new enum values woudl be 2
> additions + 1 deletion lines.
> 
>  enum xenon_phy_type_enum {
>       EMMC_5_0_PHY,
> -      EMMC_5_1_PHY
> +      EMM
> C_5_1_PHY,
> +      EMMC_5_2_PHY
>  }
> 
> Either way (leave NR_PHY_TYPES or remove NR_PHY_TYPES) is fine from my
> side.
> 

Preference on this ?
If no objection [nobody insists] I would keep.

I don't feel strongly about it [dropping NR_PHY_TYPES or not].

Thanks
Alex

> Thanks
> Alex
> 
> > regards,
> > dan carpenter
> > 
