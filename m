From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 0/1] block: Add test-iosched scheduler
Date: Fri, 8 Jun 2012 16:23:21 +0530
Message-ID: <CANfBPZ8C7YY760yx9ATi1_UJ_itL0N+fVdxx0Lim-55SgGjbng@mail.gmail.com>
References: <1339011882-7919-1-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339011882-7919-1-git-send-email-merez@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 7, 2012 at 1:14 AM, Maya Erez <merez@codeaurora.org> wrote:
> The test scheduler allows testing a block device by dispatching
> specific requests according to the test case and declare PASS/FAIL
> according to the requests completion error code
>
I can't get the point. Isn't this possible purely from userspace using =
IOCTLs ?
Even otherwise, requiring to modify the scheduler for each test case
is definitely not scalable.

> Changes in v2:
> =A0 =A0- Export test-iosched functionality to allow definition of the=
 block device
> =A0 =A0 =A0tests under the block device layer
> =A0 =A0- Add registration of block device tests utilities
>
> Maya Erez (1):
> =A0block: Add test-iosched scheduler
>
> =A0Documentation/block/test-iosched.txt | =A0 39 ++
> =A0block/Kconfig.iosched =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +
> =A0block/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> =A0block/blk-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
3 +-
> =A0block/test-iosched.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1025 ++++++=
++++++++++++++++++++++++++++
> =A0include/linux/test-iosched.h =A0 =A0 =A0 =A0 | =A0218 +++++++
> =A06 files changed, 1292 insertions(+), 2 deletions(-)
> =A0create mode 100644 Documentation/block/test-iosched.txt
> =A0create mode 100644 block/test-iosched.c
> =A0create mode 100644 include/linux/test-iosched.h
>
