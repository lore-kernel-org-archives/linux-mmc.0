From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH 0/3] mmc: sunxi: Changes in the host driver
Date: Thu, 21 Jul 2016 08:28:01 +0200
Message-ID: <cover.1469082481.git.moinejf@free.fr>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBWUIYK6AKGQE7J3DUQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

While testing the eMMC access in a Banana Pi M3, I found and fixed
some problems:
- the driver was trying to set a strange rate when clk_round_rate()
  was returning an error
- the 'new timing mode' could not work because a register was not set
- with a parent clock at 1.2GHz, the output and sample phases were
  not correct for the A83T

Jean-Francois Moine (3):
  mmc: sunxi: Check the value returned by clk_round_rate
  mmc: sunxi: Set the 'New Timing' register for 8 bits DDR transfers
  mmc: sunxi: Add support to the Allwinner A83T

 drivers/mmc/host/sunxi-mmc.c | 45 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 7 deletions(-)

-- 
2.9.2
