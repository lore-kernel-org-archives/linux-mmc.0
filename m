From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 5/5] mmc: dw_mmc: Remove DW_MCI_QUIRK_NO_WRITE_PROTECT
Date: Mon, 14 Jan 2013 22:28:13 -0800
Message-ID: <20130115062813.GD20105@quad.lixom.net>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-5-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357923834-31641-5-git-send-email-dianders@chromium.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@imgtec.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2013 at 09:03:54AM -0800, Doug Anderson wrote:
> The original quirk was added in the change 'mmc: dw_mmc: add quirk to
> indicate missing write protect line'.  The original quirk was added at
> a controller level even though each slot has its own write protect (so
> the quirk should be at the slot level).  A recent change (mmc: dw_mmc:
> Add "disable-wp" device tree property) added a slot-level quirk and
> support for the quirk directly to dw_mmc.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>
