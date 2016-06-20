From: "Baranowska, BeataX" <beatax.baranowska@intel.com>
Subject: RE: [PATCH] mmc: Change the enhanced area related sysfs output
 format
Date: Mon, 20 Jun 2016 09:25:59 +0000
Message-ID: <CC22646CC0522A488A20F7A66BFD619308F0F1@irsmsx105.ger.corp.intel.com>
References: <1465893186-6399-1-git-send-email-beatax.baranowska@intel.com>
 <20160614101242.GA1603@katana> <575FDE1B.2090206@intel.com>
 <20160614124100.GA1608@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160614124100.GA1608@katana>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "gwendal@chromium.org" <gwendal@chromium.org>, "chaotian.jing@mediatek.com" <chaotian.jing@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Tuesday, June 14, 2016 2:41 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Baranowska, BeataX <beatax.baranowska@intel.com>;
> ulf.hansson@linaro.org; aisheng.dong@nxp.com; wsa+renesas@sang-
> engineering.com; gwendal@chromium.org; chaotian.jing@mediatek.com;
> linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Jarosz,
> SebastianX <sebastianx.jarosz@intel.com>; Dong, Chuanxiao
> <chuanxiao.dong@intel.com>
> Subject: Re: [PATCH] mmc: Change the enhanced area related sysfs output
> format
> 
> On Tue, Jun 14, 2016 at 01:36:11PM +0300, Adrian Hunter wrote:
> > On 14/06/16 13:12, Wolfram Sang wrote:
> > > On Tue, Jun 14, 2016 at 10:33:06AM +0200, Beata Baranowska wrote:
> > >> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > >>
> > >> When the enhanced area feature was not enabled, the related sysfs
> > >> will have -EINVAL(-22) value, so change the sysfs output format to
> > >> display the correct value.
> > >>
> > >> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > >
> > > What about introducing attribute_group an use the is_visible
> > > callback there, so they won't get displayed at all?
> > >
> >
> > Except that it is an ABI:
> >
> > 	Documentation/ABI/testing/sysfs-devices-mmc
> 
> And broken ever since if this patch is needed... that being said, I don't really
> have a strong opinion on my suggestion. I see the file is out there for >5
> years.

When functionality was implemented for situation when enhanced area is not enabled the value 0 was being used.
After someone's suggestion 0 was changed into -ENIVAL. Variables are still unsigned. 
This patch was to change displaying part from unsigned into signed but you are right it should be investigated.

I think we could:
- use 0 instead of -ENIVAL and then leave variables unsigned as it is,
- change variables and printfs into signed
- or leave it unchanged as the file is out there for >5

Please let me know your suggestions if the update of the patch is appreciated.

Beata
