From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER
 if GPIO not yet available
Date: Sun, 17 Jun 2012 20:06:31 -0600
Message-ID: <4FDE8D27.6030508@wwwdotorg.org>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339927893-8842-1-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roland Stigge <stigge@antcom.de>
Cc: linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, rmk+kernel@arm.linux.org.uk, cjb@laptop.org, ulf.hansson@stericsson.com, aletes.xgr@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 06/17/2012 04:11 AM, Roland Stigge wrote:
> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
> respective GPIO is not (yet) available. This is useful if driver's probe()
> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
> can be probed again later on.
> 
> The function still returns -EINVAL on other errors (parse error or node doesn't
> exist). This way, the case of an optional/intentionally missing GPIO is handled
> appropriately.

While I agree this is a correct change, it is going to break some
existing code - at least sound/soc/tegra/tegra_{wm8903.c,alc5632.c}. I'm
happy to send patches for those files though (is this going into 3.5 or
3.6?). However, have you audited all existing callers (including
indirect, e.g. through plain of_get_named_gpio()) for issues this will
cause?
