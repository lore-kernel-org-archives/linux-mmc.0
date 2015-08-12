From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: Driver for CB710/720 memory card reader (MMC part)
Date: Wed, 12 Aug 2015 14:00:51 +0300
Message-ID: <20150812110051.GC22571@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44076 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbbHLLBE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2015 07:01:04 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: mirq-linux@rere.qmqm.pl
Cc: linux-mmc@vger.kernel.org

Hello Micha=C5=82 Miros=C5=82aw,

The patch 5f5bac8272be: "mmc: Driver for CB710/720 memory card reader
(MMC part)" from May 22, 2009, leads to the following static checker
warning:

	drivers/mmc/host/cb710-mmc.c:579 cb710_mmc_set_ios()
	warn: 'err' can be either negative or positive

drivers/mmc/host/cb710-mmc.c
   112 =20
   113  static int cb710_check_event(struct cb710_slot *slot, u8 what)
   114  {
   115          u16 status;
   116 =20
   117          status =3D cb710_read_port_16(slot, CB710_MMC_STATUS_PO=
RT);
   118 =20
   119          if (status & CB710_MMC_S0_FIFO_UNDERFLOW) {
   120                  /* it is just a guess, so log it */
   121                  dev_dbg(cb710_slot_dev(slot),
   122                          "CHECK : ignoring bit 6 in status %04X\=
n", status);
   123                  cb710_write_port_8(slot, CB710_MMC_STATUS0_PORT=
,
   124                          CB710_MMC_S0_FIFO_UNDERFLOW);
   125                  status &=3D ~CB710_MMC_S0_FIFO_UNDERFLOW;
   126          }
   127 =20
   128          if (status & CB710_MMC_STATUS_ERROR_EVENTS) {
   129                  dev_dbg(cb710_slot_dev(slot),
   130                          "CHECK : returning EIO on status %04X\n=
", status);
   131                  cb710_write_port_8(slot, CB710_MMC_STATUS0_PORT=
, status & 0xFF);
   132                  cb710_write_port_8(slot, CB710_MMC_STATUS1_PORT=
,
   133                          CB710_MMC_S1_RESET);
   134                  return -EIO;
   135          }
   136 =20
   137          /* 'what' is a bit in MMC_STATUS1 */
   138          if ((status >> 8) & what) {
   139                  cb710_write_port_8(slot, CB710_MMC_STATUS1_PORT=
, what);
   140                  return 1;

There are two callers to this function.  It appears to me that one
expects zero on error and one expects non-zero on error.  It is
confusing and there are no comments explaining the return codes.

   141          }
   142 =20
   143          return 0;
   144  }

regards,
dan carpenter
