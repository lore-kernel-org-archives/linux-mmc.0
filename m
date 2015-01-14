From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/3] ARM: edma: Correct header file usage
Date: Wed, 14 Jan 2015 15:21:03 +0530
Message-ID: <54B63C07.9010301@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux@arm.linux.org.uk, arnd@arndb.de, vinod.koul@intel.com, khilman@deeprootsystems.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, Liam Girdwood <lgirdwood@gmail.com>, dmaengine@vger.kernel.org, ulf.hansson@linaro.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 27 November 2014 04:11 PM, Peter Ujfalusi wrote:
> Hi,
> 
> The linux/platform_data/edma.h file was used for API definition as well, which
> is not correct since the header should only contain platform data related
> structures, defines, etc.

I would like to queue this series through ARM-SoC for v3.20 with Mark's
and Ulf's acks added. I know its not the complete clean-up everyone
wanted to see but I also know Peter working on doing the complete
clean-up as well. So we are firmly on the path to removing
arch/arm/common/edma.c.

Thanks,
Sekhar
