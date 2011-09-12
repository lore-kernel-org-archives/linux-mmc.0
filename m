From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: clarify how to use post_req in case of
	errors
Date: Mon, 12 Sep 2011 16:05:14 +0200
Message-ID: <CACRpkdZJq1C4TyXbW7WuV3xgC1AhV-3aL0L8+svrPYi_FhT_Qw@mail.gmail.com>
References: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
	<1314624959-4634-2-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314624959-4634-2-git-send-email-per.forlin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linaro-dev@lists.linaro.org, Balaji T Krishnamoorthy <balajitk@ti.com>, linux-mmc@vger.kernel.org, Santosh <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sourav Poddar <sourav.poddar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 29, 2011 at 3:35 PM, Per Forlin <per.forlin@linaro.org> wrote:

> The err condition in post_req() is set to undo a call made
> to pre_req() that hasn't been started yet.
> The err condition is not set if an MMC request returns error.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>

Comments look correct so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
