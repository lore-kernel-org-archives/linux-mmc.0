From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 13 Jan 2014 14:32:46 +0900
Message-ID: <001c01cf1020$e3e1aed0$aba50c70$%jun@samsung.com>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
 <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
 <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com>
 <52CFFFDA.8050108@linaro.org>
 <001501cf1004$7b1f34b0$715d9e10$%jun@samsung.com>
 <52D3515B.7040008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <52D3515B.7040008@linaro.org>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'zhangfei' <zhangfei.gao@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Mon, January 13, 2014, zhangfei wrote:
> On 01/13/2014 10:09 AM, Seungwon Jeon wrote:
> > On Fri, January 10, 2014, Zhangfei Gao wrote:
> >> On 01/10/2014 09:39 PM, Seungwon Jeon wrote:
> >>>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >>>> +{
> >>>> +	struct dw_mci_k3_priv_data *priv = host->priv;
> >>>> +	u32 rate = priv->clk_table[ios->timing];
> >>>
> >>> First, sorry for quick review even though your effort.
> >>> But I still worry about this change.
> >>> Currently k3 host's clock table depends on value number of SD/MMC mode value.
> >>> It seems close to identifier for eachg mode. I think it's not good way to use as table's index.
> >>> Can you modify to mmc_clk_determine_rate() in your another patch-set?
> >>> I guess required actual target rate could be determined depending on ios->clock.
> >>>
> >>
> >> No, it can not get input clock source rate simply from ios->clock, also
> >> requied info like which controller, which mode etc.
> >> Here is setting clock source rate, not the working clock rate.
> >>
> >> For example, emmc init clock source rate is 13M, while sd init clock
> >> source is 25M, it can not simply get such info from ios->clock.
> >> And for HS200, emmc may have to set clock source rate to 104M since the
> >> controller limitation and can not work stable as 208M.
> >
> > Yes, clock table is source clock rate, not actual working clock rate.
> > I was not saying that 'ios->clock' would be used for source clock directly.
> > I meant that you can adjust the source clock rate depending on 'ios->clock'.
> > You've already done with clock table similarly in mmc_clk_determine_rate().
> >
> > For example, in case of HS200, 'ios->clock' will be passed with 200MHz.
> > And then, mmc_clk_determine_rate() can set the 'rate & best' to 100000000 and 720000000 respectively.
> > Also, 'ios->clock' with 400KHz or less may be passed for init clock.
> > If clock id is HI3620_SD_CIUCLK, 'rate & best' can be selected with 13000000 and 26000000.
> > If not and it's case of MMC,  'rate & best' can be selected with 25000000 and 180000000.
> > If it should be considered with other conditions, please let me know.
> 
> However, I am afraid this will make things complicated rather than
> simplified.
> 
> The function mmc_clk_determine_rate() will need the info which
> controller it is, what's the init clock rate, what's the max clock rate,
> and what's the limitation, which may be different as different soc, and
> can not be hardcoded.
> The limitation may in HS200 and SDR104 mode.
> 
> The plan is only input init rate and max rate instead of the table,
> while others directly use ios->clock, only if the the limitation resolved.

Handling mmc clock for hi3620 is in drivers/clk/hisilicon/clk-hi3620.c, right?
Currently only hi3620 has been introduced.
If hi3620's host has a limitation, clk-hi3620.c can handle clock range(init, max) for source clock enough.
I feel like clock table is redundant.
Ok. It's just my suggestion.  But I still point dependency of mode index number.
K3's clock table refers and depends mode definition value from include/linux/mmc/host.h
If new mode is added or modified, it should be considered and also may make complicated.

Thanks,
Seungwon Jeon
