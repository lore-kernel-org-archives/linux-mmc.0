From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] leds-class: change back LEDS_CLASS to tristate instead
	of bool
Date: Mon, 10 Oct 2011 22:54:09 +0400
Message-ID: <20111010185409.GA8787@oksana.dev.rtsoft.ru>
References: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: akpm@google.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, manuel.lauss@gmail.com, cjb@laptop.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 27, 2011 at 04:50:32PM +0800, Bryan Wu wrote:
> LEDS_CLASS is required by leds and trigger drivers, but we can build it as
> module.  So change this option back as tristate and treak the help message
> as well.
> 
> LEDS_TRIGGERS depends on LEDS_CLASSS, which should be tristate.  So set it
> as tristate too and update header files as well.
> 
> Change those ifdefs to take care of module configuration.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

Won't this break linking if POWER_SUPPLY=y and LEDS_TRIGGERS=m?

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
