From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] mmc-block: Fine-tuning for mmc_blk_ioctl_copy_from_user()
Date: Fri, 19 Aug 2016 23:07:18 +0200
Message-ID: <68870228-c6a0-5de9-daee-2522a1303857@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@fb.com>, Jon Hunter <jonathanh@nvidia.com>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 19 Aug 2016 23:00:23 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use memdup_user()
  Rename jump labels

 drivers/mmc/card/block.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

-- 
2.9.3
