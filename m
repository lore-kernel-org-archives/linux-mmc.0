From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH V4 1/3] mmc: sdhci: Add size for caller in
 init+register
Date: Fri, 31 May 2013 08:41:40 -0700
Message-ID: <51A8C4B4.6020104@broadcom.com>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1369860607-25572-1-git-send-email-csd@broadcom.com>
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
Cc: linux-doc@vger.kernel.org, Christian Daudt <csd@broadcom.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Wei WANG <wei_wang@realsil.com.cn>, matt.porter@linaro.org, Kevin Liu <kliu5@marvell.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, csd_b@daudt.org, Viresh Kumar <viresh.kumar@linaro.org>, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, Bill Pemberton <wfp5p@virginia.edu>, Haojian Zhuang <haojian.zhuang@gmail.com>, Stephen Warren <swarren@nvidia.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroc>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,
  Can you pls take this patch and the one named "[PATCH V4 2/3] ARM: 
mmc: bcm281xx SDHCI driver" into your tree ?

  Thanks,
     csd.

On 13-05-29 01:50 PM, Christian Daudt wrote:
> Add a param to allow users of sdhci_pltfm to allocate private space
> in calls to sdhci_pltfm_init+sdhci_pltfm_register. This is implemented
> in the same way as sdhci does for its users.
>   None of the users have been migrated yet and are passing in zero to
> retain their private allocation.
>
> - todo: migrate clients to using allocation this way
> - todo: remove priv variable once migration is complete
>
> Also removed unused variable in sdhci_pltfm_init fn
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
