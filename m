From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8] mmc: moxart: Add MOXA ART SD/MMC driver
Date: Wed, 23 Apr 2014 15:37:37 +0200
Message-ID: <201404231537.37396.arnd@arndb.de>
References: <1390301550-478-1-git-send-email-jonas.jensen@gmail.com>
 <1397051651-29501-1-git-send-email-jonas.jensen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397051651-29501-1-git-send-email-jonas.jensen@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonas Jensen <jonas.jensen@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, chris@printf.net, linux-kernel@vger.kernel.org, arm@kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 09 April 2014, Jonas Jensen wrote:
> Add SD/MMC driver for MOXA ART SoCs.
> 
> The "MOXA ART MMC controller" is likely a faraday "ftsdc010",
> a controller with support in U-Boot:
> 
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/mmc/ftsdc010_mci.c
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
