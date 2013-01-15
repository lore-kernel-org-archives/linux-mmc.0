From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 3/5] mmc: dw_mmc: exynos: Remove code for wp-gpios
Date: Mon, 14 Jan 2013 22:25:53 -0800
Message-ID: <20130115062553.GA20105@quad.lixom.net>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357923834-31641-3-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@imgtec.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2013 at 09:03:52AM -0800, Doug Anderson wrote:
> The exynos code claimed the write protect with devm_gpio_request() but
> never did anything with it.  That meant that anyone using a write
> protect GPIO would effectively be write protected all the time.
> 
> The handling for wp-gpios belongs in the main dw_mmc driver and has
> been moved there.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
