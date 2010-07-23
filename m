From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v4] Samsung: add new card detection methods in s3c-sdhci
	driver (platform part)
Date: Fri, 23 Jul 2010 09:03:20 +0900
Message-ID: <004101cb29fa$7ad36bf0$707a43d0$%kim@samsung.com>
References: <000501cb2977d6cf210846d630$%szyprowski@samsung.com>
	<1279790980-29583-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1279790980-29583-1-git-send-email-m.szyprowski@samsung.com>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kyungmin.park@samsung.com, akpm@linux-foundation.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Marek Szyprowski wrote:
> 
> On some Samsung SoCs not all SDHCI controllers have card detect (CD)
> line. For some embedded designs it is not even needed, because ususally
> the device (like SDIO flash memory or wifi controller) is permanently
> wired to the controller. There are also systems which have a card detect
> line connected to some of the external interrupt lines or the presence
> of the card depends on some other actions (like enabling a power
> regulator).
> 
> This patch adds all required changes to platform support code, so
> another patch, which extends the driver with support for the new card
> detection methods can be applied.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Ok..will apply soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
> 
> This a resend of the previous patch.
> 
> I hope these changes to platform specific code gets merged soon, so the
> changes to the driver can be merged as well.
> 
> The patch has been prepared against linux-next kernel tree from 20100722.
> 
> Changes since V3:
> - renamed patch to avoid confusion with the patch for the s3c-sdhci driver
>   itself - added "(platform part)" in subject
> 
> Changes since V2:
> - added support for HSMMC3 device
> 
> Changes since V1:
> - added support for gpio external interrupt card based detect method
>   directly to sdhci-s3c driver
> - removed s3c64xx compilation fix patch from the series
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
