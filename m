From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-arasan: mark sdhci_arasan_reset()
 static
Date: Thu, 29 Sep 2016 23:30:12 -0700
Message-ID: <20160930063012.GL16583@xsjsorenbubuntu>
References: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
 <1475199459-4775-2-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475199459-4775-2-git-send-email-baoyou.xie@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: michal.simek@xilinx.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, xie.baoyou@zte.com.cn, han.fei@zte.com.cn, tang.qiang007@zte.com.cn
List-Id: linux-mmc@vger.kernel.org

On Fri, 2016-09-30 at 09:37:39 +0800, Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/mmc/host/sdhci-of-arasan.c:253:6: warning: no previous prototype for 'sdhci_arasan_reset' [-Wmissing-prototypes]
> 
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> So this patch marks it 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

There is already a patch for this:
https://patchwork.kernel.org/patch/9349805/

	Sören
