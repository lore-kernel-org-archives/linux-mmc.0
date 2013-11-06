From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: sh_mmcif: remove now superfluous sh_mmcif_host::data member
Date: Wed, 6 Nov 2013 19:16:03 +0300
Message-ID: <20131106161603.GI15603@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35734 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab3KFQQP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 11:16:15 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-mmc@vger.kernel.org

Hello Guennadi Liakhovetski,

This is a semi-automatic email about new static checker warnings.

The patch 699834045f1e: "mmc: sh_mmcif: remove now superfluous 
sh_mmcif_host::data member" from Dec 26, 2011, leads to the following 
Smatch complaint:

drivers/mmc/host/sh_mmcif.c:822 sh_mmcif_set_cmd()
	 error: we previously assumed 'data' could be null (see line 787)

drivers/mmc/host/sh_mmcif.c
   786		/* WDAT / DATW */
   787		if (data) {
                    ^^^^
Check.

   788			tmp |= CMD_SET_WDAT;
   789			switch (host->bus_width) {
   790			case MMC_BUS_WIDTH_1:
   791				tmp |= CMD_SET_DATW_1;
   792				break;
   793			case MMC_BUS_WIDTH_4:
   794				tmp |= CMD_SET_DATW_4;
   795				break;
   796			case MMC_BUS_WIDTH_8:
   797				tmp |= CMD_SET_DATW_8;
   798				break;
   799			default:
   800				dev_err(&host->pd->dev, "Unsupported bus width.\n");
   801				break;
   802			}
   803			switch (host->timing) {
   804			case MMC_TIMING_UHS_DDR50:
   805				/*
   806				 * MMC core will only set this timing, if the host
   807				 * advertises the MMC_CAP_UHS_DDR50 capability. MMCIF
   808				 * implementations with this capability, e.g. sh73a0,
   809				 * will have to set it in their platform data.
   810				 */
   811				tmp |= CMD_SET_DARS;
   812				break;
   813			}
   814		}
   815		/* DWEN */
   816		if (opc == MMC_WRITE_BLOCK || opc == MMC_WRITE_MULTIPLE_BLOCK)
   817			tmp |= CMD_SET_DWEN;
   818		/* CMLTE/CMD12EN */
   819		if (opc == MMC_READ_MULTIPLE_BLOCK || opc == MMC_WRITE_MULTIPLE_BLOCK) {
   820			tmp |= CMD_SET_CMLTE | CMD_SET_CMD12EN;
   821			sh_mmcif_bitset(host, MMCIF_CE_BLOCK_SET,
   822					data->blocks << 16);
                                        ^^^^^^^^^^^^
Dereference.

We used to assume that host->data might be NULL but that mrq->data was
a valid pointer.  But now they are unified into one pointer.

   823		}
   824		/* RIDXC[1:0] check bits */

regards,
dan carpenter
