From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v4 1/5] mmc: dw_mmc: Add "disable-wp" device tree property
Date: Fri, 11 Jan 2013 17:12:45 +0000
Message-ID: <CAFbHwiTqpmiStLuLWn=aGQmR9yL+JOtYt=EkSAPf=PnTi0W1xw@mail.gmail.com>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
	<1357923834-31641-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1357923834-31641-1-git-send-email-dianders@chromium.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@imgtec.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2013 at 5:03 PM, Doug Anderson <dianders@chromium.org> wrote:
> The "disable-wp" property is used to specify that a given SD card slot
> doesn't have a concept of write protect.  This eliminates the need for
> special case code for SD slots that should never be write protected
> (like a micro SD slot or a dev board).
>
> The dw_mmc driver is special in needing to specify "disable-wp"
> because the lack of a "wp-gpios" property means to use the special
> purpose write protect line.  On some other mmc devices the lack of
> "wp-gpios" means that write protect should be disabled.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

This looks ok to me too.

Acked-by: Will Newton <will.newton@imgtec.com>
