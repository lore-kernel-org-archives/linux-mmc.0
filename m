From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
Date: Fri, 12 Oct 2018 23:57:36 +0900
Message-ID: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-mmc@vger.kernel.org

In further testing in uniphier-sd.c,
I found my stupid mistakes.

Ulf,

Can you squash this series into
3fd784f745dd
"mmc: uniphier-sd: add UniPhier SD/eMMC controller driver"
if you have a chance to do rebase?

Of course, it is OK to apply this series
on top of your next branch if it is too late.



Masahiro Yamada (2):
  mmc: uniphier-sd: fix DMA disabling
  mmc: uniphier-sd: avoid using broken DMA RX channel

 drivers/mmc/host/uniphier-sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.7.4
