From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Fri, 6 Dec 2013 02:39:14 +0100
Message-ID: <201312060239.14832.arnd@arndb.de>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
 <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Dinh Nguyen <dinguyen@altera.com>
List-Id: linux-mmc@vger.kernel.org

On Friday 08 November 2013, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>

We are currently having the exact same discussion problem on the altera
version of dw_mmc: It seems that all this driver does in addition to the
common code is to have a custom way to set up the card clocks.

In both cases, there is a custom piece of IP logic providing this clock
(here it is in the "hisilicon,pctrl" node). IMHO that should be a proper
clock driver so you can use the existing call to clk_set_rate to set
it up and not need a special platform driver at all.

	Arnd
