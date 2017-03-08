From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v11 2/9] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Wed, 8 Mar 2017 18:52:56 +0100
Message-ID: <20170308175256.GA14610@hardcore>
References: <20170206133953.8390-1-jglauber@cavium.com>
 <20170206133953.8390-3-jglauber@cavium.com>
 <CAPDyKFpZs-WZ32NQTc3zY6RdWJecZkUvbEbszAJfv4H2Rw2JCQ@mail.gmail.com>
 <20170307104922.GA19134@hardcore>
 <CAPDyKFrc5T1A=bcYtDELmpxNuwbDCAKxjZP3=cx6N9s5RZ-JuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrc5T1A=bcYtDELmpxNuwbDCAKxjZP3=cx6N9s5RZ-JuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 08, 2017 at 10:45:19AM +0100, Ulf Hansson wrote:
[...]

> > May I ask why you dislike the bitfields? Or maybe it is easier when I
> > explain why I decided to keep them:
> 
> My main concern is that is different compared to how we deal with
> endian issues in the kernel.
> 
> I just don't like homebrewed hacks, but prefers sticking to defacto
> standard methods.

I don't see it as a homebrew hack, the BIG/LITTLE_ENDIAN_BITFIELD macros
are already used in the kernel. In my eyes it is a straight-forward and
obvious thing.

> >
> > - One drawback of bitfields is poor performance on some architectures.
> >   That is not the case here, both MIPS64 and ARM64 have instructions
> >   capable of using bitfields without performance impact.
> >
> > - The used bitfield are all aligned to word size, usually the pattern in
> >   the driver is to readq / writeq the whole word (therefore the union
> >   val) and then set or read certain fields. That should avoid IMHO the
> >   unspecified behaviour the C standard mentions.
> >
> > - I prefer BIT_ULL and friends for single bits, but using macros for
> >   more then one bit is (again IMHO) much less readable then using
> >   bitfiels here. And all the endianess definitions are _only_ in the
> >   header file.
> >
> > Also, if I need to convert all of these I'll probably add some new bugs.
> > What we have currently works fine on both MIPS and ARM64.
> 
> I understand that is will have an impact, however there are plenty of
> good references in the kernel for how to do this.

As an experiment I've converted the bitfields to use FIELD_PREP|GET or
plain logic, see below patch (against unreleased v12, just to show the
difference).

While the header file looks cleaner I think the code is much harder to
read. Is there a better way to do this? Is it really worth it?

thanks,
Jan

> [...]
> 
> Kind regards
> Uffe

---

diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
index b507a7a..b899720 100644
--- a/drivers/mmc/host/cavium-mmc.c
+++ b/drivers/mmc/host/cavium-mmc.c
@@ -13,6 +13,7 @@
  *   Steven J. Hill <steven.hill@cavium.com>
  *   Jan Glauber <jglauber@cavium.com>
  */
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -151,14 +152,14 @@ static struct cvm_mmc_cr_mods cvm_mmc_get_cr_mods(struct mmc_command *cmd)
 
 static void check_switch_errors(struct cvm_mmc_host *host)
 {
-	union mio_emm_switch emm_switch;
+	u64 emm_switch;
 
-	emm_switch.val = readq(host->base + MIO_EMM_SWITCH(host));
-	if (emm_switch.s.switch_err0)
+	emm_switch = readq(host->base + MIO_EMM_SWITCH(host));
+	if (emm_switch & MIO_EMM_SWITCH_ERR0)
 		dev_err(host->dev, "Switch power class error\n");
-	if (emm_switch.s.switch_err1)
+	if (emm_switch & MIO_EMM_SWITCH_ERR1)
 		dev_err(host->dev, "Switch hs timing error\n");
-	if (emm_switch.s.switch_err2)
+	if (emm_switch & MIO_EMM_SWITCH_ERR2)
 		dev_err(host->dev, "Switch bus width error\n");
 }
 
@@ -168,28 +169,25 @@ static void check_switch_errors(struct cvm_mmc_host *host)
  */
 static void do_switch(struct cvm_mmc_host *host, u64 val)
 {
-	union mio_emm_rsp_sts rsp_sts;
-	union mio_emm_switch emm_switch;
+	u64 rsp_sts, emm_switch = val;
 	int retries = 100;
 	int bus_id;
 
-	emm_switch.val = val;
-
 	/*
 	 * Modes setting only taken from slot 0. Work around that hardware
 	 * issue by first switching to slot 0.
 	 */
-	bus_id = emm_switch.s.bus_id;
-	emm_switch.s.bus_id = 0;
-	writeq(emm_switch.val, host->base + MIO_EMM_SWITCH(host));
+	bus_id = FIELD_GET(MIO_EMM_SWITCH_BUS_ID, emm_switch);
+	emm_switch &= ~MIO_EMM_SWITCH_BUS_ID;
+	writeq(emm_switch, host->base + MIO_EMM_SWITCH(host));
 
-	emm_switch.s.bus_id = bus_id;
-	writeq(emm_switch.val, host->base + MIO_EMM_SWITCH(host));
+	emm_switch |= FIELD_PREP(MIO_EMM_SWITCH_BUS_ID, bus_id);
+	writeq(emm_switch, host->base + MIO_EMM_SWITCH(host));
 
 	/* wait for the switch to finish */
 	do {
-		rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS(host));
-		if (!rsp_sts.s.switch_val)
+		rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
+		if (!(rsp_sts & MIO_EMM_RSP_STS_SWITCH_VAL))
 			break;
 		udelay(10);
 	} while (--retries);
@@ -222,20 +220,18 @@ static void set_wdog(struct cvm_mmc_slot *slot, unsigned int ns)
 static void cvm_mmc_reset_bus(struct cvm_mmc_slot *slot)
 {
 	struct cvm_mmc_host *host = slot->host;
-	union mio_emm_switch emm_switch;
-	u64 wdog = 0;
+	u64 emm_switch, wdog;
 
-	emm_switch.val = readq(slot->host->base + MIO_EMM_SWITCH(host));
-	wdog = readq(slot->host->base + MIO_EMM_WDOG(host));
+	emm_switch = readq(slot->host->base + MIO_EMM_SWITCH(host));
+	emm_switch &= ~(MIO_EMM_SWITCH_EXE | MIO_EMM_SWITCH_ERR0 |
+			MIO_EMM_SWITCH_ERR1 | MIO_EMM_SWITCH_ERR2 |
+			MIO_EMM_SWITCH_BUS_ID);
+	emm_switch |= FIELD_PREP(MIO_EMM_SWITCH_BUS_ID, slot->bus_id);
 
-	emm_switch.s.switch_exe = 0;
-	emm_switch.s.switch_err0 = 0;
-	emm_switch.s.switch_err1 = 0;
-	emm_switch.s.switch_err2 = 0;
-	emm_switch.s.bus_id = slot->bus_id;
-	do_switch(slot->host, emm_switch.val);
+	wdog = readq(slot->host->base + MIO_EMM_WDOG(host));
+	do_switch(slot->host, emm_switch);
 
-	slot->cached_switch = emm_switch.val;
+	slot->cached_switch = emm_switch;
 
 	msleep(20);
 
@@ -247,8 +243,7 @@ static void cvm_mmc_switch_to(struct cvm_mmc_slot *slot)
 {
 	struct cvm_mmc_host *host = slot->host;
 	struct cvm_mmc_slot *old_slot;
-	union mio_emm_switch emm_switch;
-	union mio_emm_sample emm_sample;
+	u64 emm_sample, emm_switch;
 
 	if (slot->bus_id == host->last_slot)
 		return;
@@ -260,14 +255,14 @@ static void cvm_mmc_switch_to(struct cvm_mmc_slot *slot)
 	}
 
 	writeq(slot->cached_rca, host->base + MIO_EMM_RCA(host));
-	emm_switch.val = slot->cached_switch;
-	emm_switch.s.bus_id = slot->bus_id;
-	do_switch(host, emm_switch.val);
+	emm_switch = slot->cached_switch;
+	emm_switch &= ~MIO_EMM_SWITCH_BUS_ID;
+	emm_switch |= FIELD_PREP(MIO_EMM_SWITCH_BUS_ID, slot->bus_id);
+	do_switch(host, emm_switch);
 
-	emm_sample.val = 0;
-	emm_sample.s.cmd_cnt = slot->cmd_cnt;
-	emm_sample.s.dat_cnt = slot->dat_cnt;
-	writeq(emm_sample.val, host->base + MIO_EMM_SAMPLE(host));
+	emm_sample = FIELD_PREP(MIO_EMM_SAMPLE_CMD_CNT, slot->cmd_cnt) |
+		     FIELD_PREP(MIO_EMM_SAMPLE_DAT_CNT, slot->dat_cnt);
+	writeq(emm_sample, host->base + MIO_EMM_SAMPLE(host));
 
 	host->last_slot = slot->bus_id;
 }
@@ -315,16 +310,16 @@ static void do_write(struct mmc_request *req)
 }
 
 static void set_cmd_response(struct cvm_mmc_host *host, struct mmc_request *req,
-			     union mio_emm_rsp_sts *rsp_sts)
+			     u64 rsp_sts)
 {
 	u64 rsp_hi, rsp_lo;
 
-	if (!rsp_sts->s.rsp_val)
+	if (!(rsp_sts & MIO_EMM_RSP_STS_RSP_VAL))
 		return;
 
 	rsp_lo = readq(host->base + MIO_EMM_RSP_LO(host));
 
-	switch (rsp_sts->s.rsp_type) {
+	switch (FIELD_GET(MIO_EMM_RSP_STS_RSP_TYPE, rsp_sts)) {
 	case 1:
 	case 3:
 		req->cmd->resp[0] = (rsp_lo >> 8) & 0xffffffff;
@@ -356,13 +351,14 @@ static int finish_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 
 static int finish_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
 {
-	union mio_emm_dma_fifo_cfg fifo_cfg;
+	u64 fifo_cfg;
+	int count;
 
 	/* Check if there are any pending requests left */
-	fifo_cfg.val = readq(host->dma_base + MIO_EMM_DMA_FIFO_CFG(host));
-	if (fifo_cfg.s.count)
-		dev_err(host->dev, "%u requests still pending\n",
-			fifo_cfg.s.count);
+	fifo_cfg = readq(host->dma_base + MIO_EMM_DMA_FIFO_CFG(host));
+	count = FIELD_GET(MIO_EMM_DMA_FIFO_CFG_COUNT, fifo_cfg);
+	if (count)
+		dev_err(host->dev, "%u requests still pending\n", count);
 
 	data->bytes_xfered = data->blocks * data->blksz;
 	data->error = 0;
@@ -381,38 +377,39 @@ static int finish_dma(struct cvm_mmc_host *host, struct mmc_data *data)
 		return finish_dma_single(host, data);
 }
 
-static int check_status(union mio_emm_rsp_sts *rsp_sts)
+static int check_status(u64 rsp_sts)
 {
-	if (rsp_sts->s.rsp_bad_sts || rsp_sts->s.rsp_crc_err ||
-	    rsp_sts->s.blk_crc_err)
+	if (rsp_sts & MIO_EMM_RSP_STS_RSP_BAD_STS ||
+	    rsp_sts & MIO_EMM_RSP_STS_RSP_CRC_ERR ||
+	    rsp_sts & MIO_EMM_RSP_STS_BLK_CRC_ERR)
 		return -EILSEQ;
-	if (rsp_sts->s.rsp_timeout || rsp_sts->s.blk_timeout)
+	if (rsp_sts & MIO_EMM_RSP_STS_RSP_TIMEOUT ||
+	    rsp_sts & MIO_EMM_RSP_STS_BLK_TIMEOUT)
 		return -ETIMEDOUT;
-	if (rsp_sts->s.dbuf_err)
+	if (rsp_sts & MIO_EMM_RSP_STS_DBUF_ERR)
 		return -EIO;
 	return 0;
 }
 
 /* Try to clean up failed DMA. */
-static void cleanup_dma(struct cvm_mmc_host *host,
-			union mio_emm_rsp_sts *rsp_sts)
+static void cleanup_dma(struct cvm_mmc_host *host, u64 rsp_sts)
 {
-	union mio_emm_dma emm_dma;
-
-	emm_dma.val = readq(host->base + MIO_EMM_DMA(host));
-	emm_dma.s.dma_val = 1;
-	emm_dma.s.dat_null = 1;
-	emm_dma.s.bus_id = rsp_sts->s.bus_id;
-	writeq(emm_dma.val, host->base + MIO_EMM_DMA(host));
+	u64 emm_dma;
+
+	emm_dma = readq(host->base + MIO_EMM_DMA(host));
+	emm_dma &= ~MIO_EMM_DMA_BUS_ID;
+	emm_dma |= FIELD_PREP(MIO_EMM_DMA_VAL, 1) |
+		   FIELD_PREP(MIO_EMM_DMA_DAT_NULL, 1) |
+		   FIELD_PREP(MIO_EMM_DMA_BUS_ID, FIELD_GET(MIO_EMM_RSP_STS_BUS_ID, rsp_sts));
+	writeq(emm_dma, host->base + MIO_EMM_DMA(host));
 }
 
 irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 {
 	struct cvm_mmc_host *host = dev_id;
-	union mio_emm_rsp_sts rsp_sts;
-	union mio_emm_int emm_int;
 	struct mmc_request *req;
 	unsigned long flags = 0;
+	u64 emm_int, rsp_sts;
 	bool host_done;
 
 	if (host->need_irq_handler_lock)
@@ -421,49 +418,53 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 		__acquire(&host->irq_handler_lock);
 
 	/* Clear interrupt bits (write 1 clears ). */
-	emm_int.val = readq(host->base + MIO_EMM_INT(host));
-	writeq(emm_int.val, host->base + MIO_EMM_INT(host));
+	emm_int = readq(host->base + MIO_EMM_INT(host));
+	writeq(emm_int, host->base + MIO_EMM_INT(host));
 
-	if (emm_int.s.switch_err)
+	if (emm_int & MIO_EMM_INT_SWITCH_ERR)
 		check_switch_errors(host);
 
 	req = host->current_req;
 	if (!req)
 		goto out;
 
-	rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS(host));
+	rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
 	/*
 	 * dma_val set means DMA is still in progress. Don't touch
 	 * the request and wait for the interrupt indicating that
 	 * the DMA is finished.
 	 */
-	if (rsp_sts.s.dma_val && host->dma_active)
+	if ((rsp_sts & MIO_EMM_RSP_STS_DMA_VAL) && host->dma_active)
 		goto out;
 
-	if (!host->dma_active && emm_int.s.buf_done && req->data) {
-		unsigned int type = (rsp_sts.val >> 7) & 3;
+	if (!host->dma_active && req->data &&
+	    (emm_int & MIO_EMM_INT_BUF_DONE)) {
+		unsigned int type = (rsp_sts >> 7) & 3;
 
 		if (type == 1)
-			do_read(host, req, rsp_sts.s.dbuf);
+			do_read(host, req, rsp_sts & MIO_EMM_RSP_STS_DBUF);
 		else if (type == 2)
 			do_write(req);
 	}
 
-	host_done = emm_int.s.cmd_done || emm_int.s.dma_done ||
-		    emm_int.s.cmd_err || emm_int.s.dma_err;
+	host_done = emm_int & MIO_EMM_INT_CMD_DONE ||
+		    emm_int & MIO_EMM_INT_DMA_DONE ||
+		    emm_int & MIO_EMM_INT_CMD_ERR  ||
+		    emm_int & MIO_EMM_INT_DMA_ERR;
 
 	if (!(host_done && req->done))
 		goto no_req_done;
 
-	req->cmd->error = check_status(&rsp_sts);
+	req->cmd->error = check_status(rsp_sts);
 
 	if (host->dma_active && req->data)
 		if (!finish_dma(host, req->data))
 			goto no_req_done;
 
-	set_cmd_response(host, req, &rsp_sts);
-	if (emm_int.s.dma_err && rsp_sts.s.dma_pend)
-		cleanup_dma(host, &rsp_sts);
+	set_cmd_response(host, req, rsp_sts);
+	if ((emm_int & MIO_EMM_INT_DMA_ERR) &&
+	    (rsp_sts & MIO_EMM_RSP_STS_DMA_PEND))
+		cleanup_dma(host, rsp_sts);
 
 	host->current_req = NULL;
 	req->done(req);
@@ -478,7 +479,7 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 		spin_unlock_irqrestore(&host->irq_handler_lock, flags);
 	else
 		__release(&host->irq_handler_lock);
-	return IRQ_RETVAL(emm_int.val != 0);
+	return IRQ_RETVAL(emm_int != 0);
 }
 
 /*
@@ -487,30 +488,30 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
  */
 static u64 prepare_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 {
-	union mio_emm_dma_cfg dma_cfg;
-	int count;
-	u64 addr;
+	u64 dma_cfg, addr;
+	int count, rw;
 
 	count = dma_map_sg(host->dev, data->sg, data->sg_len,
 			   get_dma_dir(data));
 	if (!count)
 		return 0;
 
-	dma_cfg.val = 0;
-	dma_cfg.s.en = 1;
-	dma_cfg.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+	rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+	dma_cfg = FIELD_PREP(MIO_EMM_DMA_CFG_EN, 1) |
+		  FIELD_PREP(MIO_EMM_DMA_CFG_RW, rw);
 #ifdef __LITTLE_ENDIAN
-	dma_cfg.s.endian = 1;
+	dma_cfg |= FIELD_PREP(MIO_EMM_DMA_CFG_ENDIAN, 1);
 #endif
-	dma_cfg.s.size = (sg_dma_len(&data->sg[0]) / 8) - 1;
+	dma_cfg |= FIELD_PREP(MIO_EMM_DMA_CFG_SIZE,
+			      (sg_dma_len(&data->sg[0]) / 8) - 1);
 
 	addr = sg_dma_address(&data->sg[0]);
 	if (!host->big_dma_addr)
-		dma_cfg.s.adr = addr;
-	writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG(host));
+		dma_cfg |= FIELD_PREP(MIO_EMM_DMA_CFG_ADR, addr);
+	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
 	pr_debug("[%s] sg_dma_len: %u  total sg_elem: %d\n",
-		 (dma_cfg.s.rw) ? "W" : "R", sg_dma_len(&data->sg[0]), count);
+		 (rw) ? "W" : "R", sg_dma_len(&data->sg[0]), count);
 
 	if (host->big_dma_addr)
 		writeq(addr, host->dma_base + MIO_EMM_DMA_ADR(host));
@@ -523,10 +524,9 @@ static u64 prepare_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
  */
 static u64 prepare_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
 {
-	union mio_emm_dma_fifo_cmd fifo_cmd;
 	struct scatterlist *sg;
-	int count, i;
-	u64 addr;
+	u64 fifo_cmd, addr;
+	int count, i, rw;
 
 	count = dma_map_sg(host->dev, data->sg, data->sg_len,
 			   get_dma_dir(data));
@@ -550,26 +550,25 @@ static u64 prepare_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
 		 * register for the DMA addr, so no need to check
 		 * host->big_dma_addr here.
 		 */
-		fifo_cmd.val = 0;
-		fifo_cmd.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+		rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+		fifo_cmd = FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_RW, rw);
 
 		/* enable interrupts on the last element */
-		if (i + 1 == count)
-			fifo_cmd.s.intdis = 0;
-		else
-			fifo_cmd.s.intdis = 1;
+		fifo_cmd |= FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_INTDIS,
+				       (i + 1 == count) ? 0 : 1);
 
 #ifdef __LITTLE_ENDIAN
-		fifo_cmd.s.endian = 1;
+		fifo_cmd |= FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_ENDIAN, 1);
 #endif
-		fifo_cmd.s.size = sg_dma_len(sg) / 8 - 1;
+		fifo_cmd |= FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_SIZE,
+				       sg_dma_len(sg) / 8 - 1);
 		/*
 		 * The write copies the address and the command to the FIFO
 		 * and increments the FIFO's COUNT field.
 		 */
-		writeq(fifo_cmd.val, host->dma_base + MIO_EMM_DMA_FIFO_CMD(host));
+		writeq(fifo_cmd, host->dma_base + MIO_EMM_DMA_FIFO_CMD(host));
 		pr_debug("[%s] sg_dma_len: %u  sg_elem: %d/%d\n",
-			 (fifo_cmd.s.rw) ? "W" : "R", sg_dma_len(sg), i, count);
+			 (rw) ? "W" : "R", sg_dma_len(sg), i, count);
 	}
 
 	/*
@@ -596,32 +595,28 @@ static u64 prepare_dma(struct cvm_mmc_host *host, struct mmc_data *data)
 		return prepare_dma_single(host, data);
 }
 
-static void prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq,
-			    union mio_emm_dma *emm_dma)
+static u64 prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct cvm_mmc_slot *slot = mmc_priv(mmc);
+	u64 emm_dma = 0;
+
+	emm_dma = FIELD_PREP(MIO_EMM_DMA_BUS_ID, slot->bus_id) |
+		  FIELD_PREP(MIO_EMM_DMA_VAL, 1) |
+		  FIELD_PREP(MIO_EMM_DMA_SECTOR,
+			     (mrq->data->blksz == 512) ? 1 : 0) |
+		  FIELD_PREP(MIO_EMM_DMA_RW,
+			     (mrq->data->flags & MMC_DATA_WRITE) ? 1 : 0) |
+		  FIELD_PREP(MIO_EMM_DMA_BLOCK_CNT, mrq->data->blocks) |
+		  FIELD_PREP(MIO_EMM_DMA_CARD_ADDR, mrq->cmd->arg);
 
-	emm_dma->val = 0;
-	emm_dma->s.bus_id = slot->bus_id;
-	emm_dma->s.dma_val = 1;
-	emm_dma->s.sector = (mrq->data->blksz == 512) ? 1 : 0;
-	emm_dma->s.rw = (mrq->data->flags & MMC_DATA_WRITE) ? 1 : 0;
-	emm_dma->s.block_cnt = mrq->data->blocks;
-	emm_dma->s.card_addr = mrq->cmd->arg;
 	if (mmc_card_mmc(mmc->card) || (mmc_card_sd(mmc->card) &&
 	    (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
-		emm_dma->s.multi = 1;
-
-	pr_debug("[%s] blocks: %u  multi: %d\n", (emm_dma->s.rw) ? "W" : "R",
-		 mrq->data->blocks, emm_dma->s.multi);
-}
+		emm_dma |= FIELD_PREP(MIO_EMM_DMA_MULTI, 1);
 
-static void prepare_emm_int(union mio_emm_int *emm_int)
-{
-	emm_int->val = 0;
-	emm_int->s.cmd_err = 1;
-	emm_int->s.dma_done = 1;
-	emm_int->s.dma_err = 1;
+	pr_debug("[%s] blocks: %u  multi: %d\n",
+		(emm_dma & MIO_EMM_DMA_RW) ? "W" : "R",
+		 mrq->data->blocks, (emm_dma & MIO_EMM_DMA_MULTI) ? 1 : 0);
+	return emm_dma;
 }
 
 static void cvm_mmc_dma_request(struct mmc_host *mmc,
@@ -629,10 +624,8 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 {
 	struct cvm_mmc_slot *slot = mmc_priv(mmc);
 	struct cvm_mmc_host *host = slot->host;
-	union mio_emm_dma emm_dma;
-	union mio_emm_int emm_int;
 	struct mmc_data *data;
-	u64 addr;
+	u64 emm_dma, addr;
 
 	if (!mrq->data || !mrq->data->sg || !mrq->data->sg_len ||
 	    !mrq->stop || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
@@ -652,16 +645,16 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 	WARN_ON(host->current_req);
 	host->current_req = mrq;
 
-	prepare_ext_dma(mmc, mrq, &emm_dma);
+	emm_dma = prepare_ext_dma(mmc, mrq);
 	addr = prepare_dma(host, data);
 	if (!addr) {
 		dev_err(host->dev, "prepare_dma failed\n");
 		goto error;
 	}
-	prepare_emm_int(&emm_int);
 
 	host->dma_active = true;
-	host->int_enable(host, emm_int.val);
+	host->int_enable(host, MIO_EMM_INT_CMD_ERR | MIO_EMM_INT_DMA_DONE |
+			 MIO_EMM_INT_DMA_ERR);
 
 	if (host->dmar_fixup)
 		host->dmar_fixup(host, mrq->cmd, data, addr);
@@ -675,7 +668,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 		writeq(0x00b00000ull, host->base + MIO_EMM_STS_MASK(host));
 	else
 		writeq(0xe4390080ull, host->base + MIO_EMM_STS_MASK(host));
-	writeq(emm_dma.val, host->base + MIO_EMM_DMA(host));
+	writeq(emm_dma, host->base + MIO_EMM_DMA(host));
 	return;
 
 error:
@@ -733,10 +726,8 @@ static void cvm_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct cvm_mmc_slot *slot = mmc_priv(mmc);
 	struct cvm_mmc_host *host = slot->host;
 	struct mmc_command *cmd = mrq->cmd;
-	union mio_emm_int emm_int;
-	union mio_emm_cmd emm_cmd;
 	struct cvm_mmc_cr_mods mods;
-	union mio_emm_rsp_sts rsp_sts;
+	u64 emm_cmd, rsp_sts;
 	int retries = 100;
 
 	/*
@@ -761,10 +752,6 @@ static void cvm_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(host->current_req);
 	host->current_req = mrq;
 
-	emm_int.val = 0;
-	emm_int.s.cmd_done = 1;
-	emm_int.s.cmd_err = 1;
-
 	if (cmd->data) {
 		if (cmd->data->flags & MMC_DATA_READ)
 			do_read_request(host, mrq);
@@ -777,31 +764,33 @@ static void cvm_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		set_wdog(slot, 0);
 
 	host->dma_active = false;
-	host->int_enable(host, emm_int.val);
-
-	emm_cmd.val = 0;
-	emm_cmd.s.cmd_val = 1;
-	emm_cmd.s.ctype_xor = mods.ctype_xor;
-	emm_cmd.s.rtype_xor = mods.rtype_xor;
+	host->int_enable(host, MIO_EMM_INT_CMD_DONE | MIO_EMM_INT_CMD_ERR);
+
+	emm_cmd = FIELD_PREP(MIO_EMM_CMD_VAL, 1) |
+		  FIELD_PREP(MIO_EMM_CMD_CTYPE_XOR, mods.ctype_xor) |
+		  FIELD_PREP(MIO_EMM_CMD_RTYPE_XOR, mods.rtype_xor) |
+		  FIELD_PREP(MIO_EMM_CMD_BUS_ID, slot->bus_id) |
+		  FIELD_PREP(MIO_EMM_CMD_IDX, cmd->opcode) |
+		  FIELD_PREP(MIO_EMM_CMD_ARG, cmd->arg);
 	if (mmc_cmd_type(cmd) == MMC_CMD_ADTC)
-		emm_cmd.s.offset = 64 - ((cmd->data->blocks * cmd->data->blksz) / 8);
-	emm_cmd.s.bus_id = slot->bus_id;
-	emm_cmd.s.cmd_idx = cmd->opcode;
-	emm_cmd.s.arg = cmd->arg;
+		emm_cmd |= FIELD_PREP(MIO_EMM_CMD_OFFSET,
+				64 - ((cmd->data->blocks * cmd->data->blksz) / 8));
 
 	writeq(0, host->base + MIO_EMM_STS_MASK(host));
 
 retry:
-	rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS(host));
-	if (rsp_sts.s.dma_val || rsp_sts.s.cmd_val ||
-	    rsp_sts.s.switch_val || rsp_sts.s.dma_pend) {
+	rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
+	if (rsp_sts & MIO_EMM_RSP_STS_DMA_VAL ||
+	    rsp_sts & MIO_EMM_RSP_STS_CMD_VAL ||
+	    rsp_sts & MIO_EMM_RSP_STS_SWITCH_VAL ||
+	    rsp_sts & MIO_EMM_RSP_STS_DMA_PEND) {
 		udelay(10);
 		if (--retries)
 			goto retry;
 	}
 	if (!retries)
-		dev_err(host->dev, "Bad status: %Lx before command write\n", rsp_sts.val);
-	writeq(emm_cmd.val, host->base + MIO_EMM_CMD(host));
+		dev_err(host->dev, "Bad status: %Lx before command write\n", rsp_sts);
+	writeq(emm_cmd, host->base + MIO_EMM_CMD(host));
 }
 
 static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -809,8 +798,7 @@ static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct cvm_mmc_slot *slot = mmc_priv(mmc);
 	struct cvm_mmc_host *host = slot->host;
 	int clk_period = 0, power_class = 10, bus_width = 0;
-	union mio_emm_switch emm_switch;
-	u64 clock;
+	u64 clock, emm_switch;
 
 	host->acquire_bus(host);
 	cvm_mmc_switch_to(slot);
@@ -865,20 +853,20 @@ static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (clock)
 		clk_period = (host->sys_freq + clock - 1) / (2 * clock);
 
-	emm_switch.val = 0;
-	emm_switch.s.hs_timing = (ios->timing == MMC_TIMING_MMC_HS);
-	emm_switch.s.bus_width = bus_width;
-	emm_switch.s.power_class = power_class;
-	emm_switch.s.clk_hi = clk_period;
-	emm_switch.s.clk_lo = clk_period;
-	emm_switch.s.bus_id = slot->bus_id;
+	emm_switch = FIELD_PREP(MIO_EMM_SWITCH_HS_TIMING,
+				(ios->timing == MMC_TIMING_MMC_HS)) |
+		     FIELD_PREP(MIO_EMM_SWITCH_BUS_WIDTH, bus_width) |
+		     FIELD_PREP(MIO_EMM_SWITCH_POWER_CLASS, power_class) |
+		     FIELD_PREP(MIO_EMM_SWITCH_CLK_HI, clk_period) |
+		     FIELD_PREP(MIO_EMM_SWITCH_CLK_LO, clk_period) |
+		     FIELD_PREP(MIO_EMM_SWITCH_BUS_ID, slot->bus_id);
 
-	if (!switch_val_changed(slot, emm_switch.val))
+	if (!switch_val_changed(slot, emm_switch))
 		goto out;
 
 	set_wdog(slot, 0);
-	do_switch(host, emm_switch.val);
-	slot->cached_switch = emm_switch.val;
+	do_switch(host, emm_switch);
+	slot->cached_switch = emm_switch;
 out:
 	host->release_bus(host);
 }
@@ -902,7 +890,7 @@ static void cvm_mmc_set_clock(struct cvm_mmc_slot *slot, unsigned int clock)
 static int cvm_mmc_init_lowlevel(struct cvm_mmc_slot *slot)
 {
 	struct cvm_mmc_host *host = slot->host;
-	union mio_emm_switch emm_switch;
+	u64 emm_switch;
 
 	/* Enable this bus slot. */
 	host->emm_cfg |= (1ull << slot->bus_id);
@@ -911,16 +899,17 @@ static int cvm_mmc_init_lowlevel(struct cvm_mmc_slot *slot)
 
 	/* Program initial clock speed and power. */
 	cvm_mmc_set_clock(slot, slot->mmc->f_min);
-	emm_switch.val = 0;
-	emm_switch.s.power_class = 10;
-	emm_switch.s.clk_hi = (host->sys_freq / slot->clock) / 2;
-	emm_switch.s.clk_lo = (host->sys_freq / slot->clock) / 2;
+	emm_switch = FIELD_PREP(MIO_EMM_SWITCH_POWER_CLASS, 10);
+	emm_switch |= FIELD_PREP(MIO_EMM_SWITCH_CLK_HI,
+				 (host->sys_freq / slot->clock) / 2);
+	emm_switch |= FIELD_PREP(MIO_EMM_SWITCH_CLK_LO,
+				 (host->sys_freq / slot->clock) / 2);
 
 	/* Make the changes take effect on this bus slot. */
-	emm_switch.s.bus_id = slot->bus_id;
-	do_switch(host, emm_switch.val);
+	emm_switch |= FIELD_PREP(MIO_EMM_SWITCH_BUS_ID, slot->bus_id);
+	do_switch(host, emm_switch);
 
-	slot->cached_switch = emm_switch.val;
+	slot->cached_switch = emm_switch;
 
 	/*
 	 * Set watchdog timeout value and default reset value
diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
index 007f812..54aae61 100644
--- a/drivers/mmc/host/cavium-mmc.h
+++ b/drivers/mmc/host/cavium-mmc.h
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 2012-2017 Cavium Inc.
  */
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/mmc/host.h>
@@ -110,284 +111,94 @@ struct cvm_mmc_cr_mods {
 
 /* Bitfield definitions */
 
-union mio_emm_dma_fifo_cfg {
-	u64 val;
-	struct mio_emm_dma_fifo_cfg_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :48;
-		u64 clr:1;
-		u64 :3;
-		u64 int_lvl:4;
-		u64 :3;
-		u64 count:5;
-#else
-		u64 count:5;
-		u64 :3;
-		u64 int_lvl:4;
-		u64 :3;
-		u64 clr:1;
-		u64 :48;
-#endif
-	} s;
-};
-
-union mio_emm_dma_fifo_cmd {
-	u64 val;
-	struct mio_emm_dma_fifo_cmd_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :1;
-		u64 rw:1;
-		u64 :1;
-		u64 intdis:1;
-		u64 swap32:1;
-		u64 swap16:1;
-		u64 swap8:1;
-		u64 endian:1;
-		u64 size:20;
-		u64 :36;
-#else
-		u64 :36;
-		u64 size:20;
-		u64 endian:1;
-		u64 swap8:1;
-		u64 swap16:1;
-		u64 swap32:1;
-		u64 intdis:1;
-		u64 :1;
-		u64 rw:1;
-		u64 :1;
-#endif
-	} s;
-};
-
-union mio_emm_cmd {
-	u64 val;
-	struct mio_emm_cmd_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :2;
-		u64 bus_id:2;
-		u64 cmd_val:1;
-		u64 :3;
-		u64 dbuf:1;
-		u64 offset:6;
-		u64 :6;
-		u64 ctype_xor:2;
-		u64 rtype_xor:3;
-		u64 cmd_idx:6;
-		u64 arg:32;
-#else
-		u64 arg:32;
-		u64 cmd_idx:6;
-		u64 rtype_xor:3;
-		u64 ctype_xor:2;
-		u64 :6;
-		u64 offset:6;
-		u64 dbuf:1;
-		u64 :3;
-		u64 cmd_val:1;
-		u64 bus_id:2;
-		u64 :2;
-#endif
-	} s;
-};
-
-union mio_emm_dma {
-	u64 val;
-	struct mio_emm_dma_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :2;
-		u64 bus_id:2;
-		u64 dma_val:1;
-		u64 sector:1;
-		u64 dat_null:1;
-		u64 thres:6;
-		u64 rel_wr:1;
-		u64 rw:1;
-		u64 multi:1;
-		u64 block_cnt:16;
-		u64 card_addr:32;
-#else
-		u64 card_addr:32;
-		u64 block_cnt:16;
-		u64 multi:1;
-		u64 rw:1;
-		u64 rel_wr:1;
-		u64 thres:6;
-		u64 dat_null:1;
-		u64 sector:1;
-		u64 dma_val:1;
-		u64 bus_id:2;
-		u64 :2;
-#endif
-	} s;
-};
-
-union mio_emm_dma_cfg {
-	u64 val;
-	struct mio_emm_dma_cfg_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 en:1;
-		u64 rw:1;
-		u64 clr:1;
-		u64 :1;
-		u64 swap32:1;
-		u64 swap16:1;
-		u64 swap8:1;
-		u64 endian:1;
-		u64 size:20;
-		u64 adr:36;
-#else
-		u64 adr:36;
-		u64 size:20;
-		u64 endian:1;
-		u64 swap8:1;
-		u64 swap16:1;
-		u64 swap32:1;
-		u64 :1;
-		u64 clr:1;
-		u64 rw:1;
-		u64 en:1;
-#endif
-	} s;
-};
-
-union mio_emm_int {
-	u64 val;
-	struct mio_emm_int_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :57;
-		u64 switch_err:1;
-		u64 switch_done:1;
-		u64 dma_err:1;
-		u64 cmd_err:1;
-		u64 dma_done:1;
-		u64 cmd_done:1;
-		u64 buf_done:1;
-#else
-		u64 buf_done:1;
-		u64 cmd_done:1;
-		u64 dma_done:1;
-		u64 cmd_err:1;
-		u64 dma_err:1;
-		u64 switch_done:1;
-		u64 switch_err:1;
-		u64 :57;
-#endif
-	} s;
-};
-
-union mio_emm_rsp_sts {
-	u64 val;
-	struct mio_emm_rsp_sts_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :2;
-		u64 bus_id:2;
-		u64 cmd_val:1;
-		u64 switch_val:1;
-		u64 dma_val:1;
-		u64 dma_pend:1;
-		u64 :27;
-		u64 dbuf_err:1;
-		u64 :4;
-		u64 dbuf:1;
-		u64 blk_timeout:1;
-		u64 blk_crc_err:1;
-		u64 rsp_busybit:1;
-		u64 stp_timeout:1;
-		u64 stp_crc_err:1;
-		u64 stp_bad_sts:1;
-		u64 stp_val:1;
-		u64 rsp_timeout:1;
-		u64 rsp_crc_err:1;
-		u64 rsp_bad_sts:1;
-		u64 rsp_val:1;
-		u64 rsp_type:3;
-		u64 cmd_type:2;
-		u64 cmd_idx:6;
-		u64 cmd_done:1;
-#else
-		u64 cmd_done:1;
-		u64 cmd_idx:6;
-		u64 cmd_type:2;
-		u64 rsp_type:3;
-		u64 rsp_val:1;
-		u64 rsp_bad_sts:1;
-		u64 rsp_crc_err:1;
-		u64 rsp_timeout:1;
-		u64 stp_val:1;
-		u64 stp_bad_sts:1;
-		u64 stp_crc_err:1;
-		u64 stp_timeout:1;
-		u64 rsp_busybit:1;
-		u64 blk_crc_err:1;
-		u64 blk_timeout:1;
-		u64 dbuf:1;
-		u64 :4;
-		u64 dbuf_err:1;
-		u64 :27;
-		u64 dma_pend:1;
-		u64 dma_val:1;
-		u64 switch_val:1;
-		u64 cmd_val:1;
-		u64 bus_id:2;
-		u64 :2;
-#endif
-	} s;
-};
-
-union mio_emm_sample {
-	u64 val;
-	struct mio_emm_sample_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :38;
-		u64 cmd_cnt:10;
-		u64 :6;
-		u64 dat_cnt:10;
-#else
-		u64 dat_cnt:10;
-		u64 :6;
-		u64 cmd_cnt:10;
-		u64 :38;
-#endif
-	} s;
-};
-
-union mio_emm_switch {
-	u64 val;
-	struct mio_emm_switch_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		u64 :2;
-		u64 bus_id:2;
-		u64 switch_exe:1;
-		u64 switch_err0:1;
-		u64 switch_err1:1;
-		u64 switch_err2:1;
-		u64 :7;
-		u64 hs_timing:1;
-		u64 :5;
-		u64 bus_width:3;
-		u64 :4;
-		u64 power_class:4;
-		u64 clk_hi:16;
-		u64 clk_lo:16;
-#else
-		u64 clk_lo:16;
-		u64 clk_hi:16;
-		u64 power_class:4;
-		u64 :4;
-		u64 bus_width:3;
-		u64 :5;
-		u64 hs_timing:1;
-		u64 :7;
-		u64 switch_err2:1;
-		u64 switch_err1:1;
-		u64 switch_err0:1;
-		u64 switch_exe:1;
-		u64 bus_id:2;
-		u64 :2;
-#endif
-	} s;
-};
+#define MIO_EMM_DMA_FIFO_CFG_CLR	BIT_ULL(16)
+#define MIO_EMM_DMA_FIFO_CFG_INT_LVL	GENMASK_ULL(12, 8)
+#define MIO_EMM_DMA_FIFO_CFG_COUNT	GENMASK_ULL(4, 0)
+
+#define MIO_EMM_DMA_FIFO_CMD_RW		BIT_ULL(62)
+#define MIO_EMM_DMA_FIFO_CMD_INTDIS	BIT_ULL(60)
+#define MIO_EMM_DMA_FIFO_CMD_SWAP32	BIT_ULL(59)
+#define MIO_EMM_DMA_FIFO_CMD_SWAP16	BIT_ULL(58)
+#define MIO_EMM_DMA_FIFO_CMD_SWAP8	BIT_ULL(57)
+#define MIO_EMM_DMA_FIFO_CMD_ENDIAN	BIT_ULL(56)
+#define MIO_EMM_DMA_FIFO_CMD_SIZE	GENMASK_ULL(55,36)
+
+#define MIO_EMM_CMD_SKIP_BUSY	BIT_ULL(62)
+#define MIO_EMM_CMD_BUS_ID	GENMASK_ULL(61, 60)
+#define MIO_EMM_CMD_VAL		BIT_ULL(59)
+#define MIO_EMM_CMD_DBUF	BIT_ULL(55)
+#define MIO_EMM_CMD_OFFSET	GENMASK_ULL(54, 49)
+#define MIO_EMM_CMD_CTYPE_XOR	GENMASK_ULL(42, 41)
+#define MIO_EMM_CMD_RTYPE_XOR	GENMASK_ULL(40, 38)
+#define MIO_EMM_CMD_IDX		GENMASK_ULL(37, 32)
+#define MIO_EMM_CMD_ARG		GENMASK_ULL(31, 0)
+
+#define MIO_EMM_DMA_SKIP_BUSY	BIT_ULL(62)
+#define MIO_EMM_DMA_BUS_ID	GENMASK_ULL(61, 60)
+#define MIO_EMM_DMA_VAL		BIT_ULL(59)
+#define MIO_EMM_DMA_SECTOR	BIT_ULL(58)
+#define MIO_EMM_DMA_DAT_NULL	BIT_ULL(57)
+#define MIO_EMM_DMA_THRES	GENMASK_ULL(56, 51)
+#define MIO_EMM_DMA_REL_WR	BIT_ULL(50)
+#define MIO_EMM_DMA_RW		BIT_ULL(49)
+#define MIO_EMM_DMA_MULTI	BIT_ULL(48)
+#define MIO_EMM_DMA_BLOCK_CNT	GENMASK_ULL(47, 32)
+#define MIO_EMM_DMA_CARD_ADDR	GENMASK_ULL(31, 0)
+
+#define MIO_EMM_DMA_CFG_EN	BIT_ULL(63)
+#define MIO_EMM_DMA_CFG_RW	BIT_ULL(62)
+#define MIO_EMM_DMA_CFG_CLR	BIT_ULL(61)
+#define MIO_EMM_DMA_CFG_SWAP32	BIT_ULL(59)
+#define MIO_EMM_DMA_CFG_SWAP16	BIT_ULL(58)
+#define MIO_EMM_DMA_CFG_SWAP8	BIT_ULL(57)
+#define MIO_EMM_DMA_CFG_ENDIAN	BIT_ULL(56)
+#define MIO_EMM_DMA_CFG_SIZE	GENMASK_ULL(55, 36)
+#define MIO_EMM_DMA_CFG_ADR	GENMASK_ULL(35, 0)
+
+#define MIO_EMM_INT_SWITCH_ERR	BIT_ULL(6)
+#define MIO_EMM_INT_SWITCH_DONE	BIT_ULL(5)
+#define MIO_EMM_INT_DMA_ERR	BIT_ULL(4)
+#define MIO_EMM_INT_CMD_ERR	BIT_ULL(3)
+#define MIO_EMM_INT_DMA_DONE	BIT_ULL(2)
+#define MIO_EMM_INT_CMD_DONE	BIT_ULL(1)
+#define MIO_EMM_INT_BUF_DONE	BIT_ULL(0)
+
+#define MIO_EMM_RSP_STS_BUS_ID		GENMASK_ULL(61, 60)
+#define MIO_EMM_RSP_STS_CMD_VAL		BIT_ULL(59)
+#define MIO_EMM_RSP_STS_SWITCH_VAL	BIT_ULL(58)
+#define MIO_EMM_RSP_STS_DMA_VAL		BIT_ULL(57)
+#define MIO_EMM_RSP_STS_DMA_PEND	BIT_ULL(56)
+#define MIO_EMM_RSP_STS_DBUF_ERR	BIT_ULL(28)
+#define MIO_EMM_RSP_STS_DBUF		BIT_ULL(23)
+#define MIO_EMM_RSP_STS_BLK_TIMEOUT	BIT_ULL(22)
+#define MIO_EMM_RSP_STS_BLK_CRC_ERR	BIT_ULL(21)
+#define MIO_EMM_RSP_STS_RSP_BUSYBIT	BIT_ULL(20)
+#define MIO_EMM_RSP_STS_STP_TIMEOUT	BIT_ULL(19)
+#define MIO_EMM_RSP_STS_STP_CRC_ERR	BIT_ULL(18)
+#define MIO_EMM_RSP_STS_STP_BAD_STS	BIT_ULL(17)
+#define MIO_EMM_RSP_STS_STP_VAL		BIT_ULL(16)
+#define MIO_EMM_RSP_STS_RSP_TIMEOUT	BIT_ULL(15)
+#define MIO_EMM_RSP_STS_RSP_CRC_ERR	BIT_ULL(14)
+#define MIO_EMM_RSP_STS_RSP_BAD_STS	BIT_ULL(13)
+#define MIO_EMM_RSP_STS_RSP_VAL		BIT_ULL(12)
+#define MIO_EMM_RSP_STS_RSP_TYPE	GENMASK_ULL(11, 9)
+#define MIO_EMM_RSP_STS_CMD_TYPE	GENMASK_ULL(8, 7)
+#define MIO_EMM_RSP_STS_CMD_IDX		GENMASK_ULL(6, 1)
+#define MIO_EMM_RSP_STS_CMD_DONE	BIT_ULL(0)
+
+#define MIO_EMM_SAMPLE_CMD_CNT		GENMASK_ULL(25, 16)
+#define MIO_EMM_SAMPLE_DAT_CNT		GENMASK_ULL(9, 0)
+
+#define MIO_EMM_SWITCH_BUS_ID		GENMASK_ULL(61, 60)
+#define MIO_EMM_SWITCH_EXE		BIT_ULL(59)
+#define MIO_EMM_SWITCH_ERR0		BIT_ULL(58)
+#define MIO_EMM_SWITCH_ERR1		BIT_ULL(57)
+#define MIO_EMM_SWITCH_ERR2		BIT_ULL(56)
+#define MIO_EMM_SWITCH_HS_TIMING	BIT_ULL(48)
+#define MIO_EMM_SWITCH_BUS_WIDTH	GENMASK_ULL(42, 40)
+#define MIO_EMM_SWITCH_POWER_CLASS	GENMASK_ULL(35, 32)
+#define MIO_EMM_SWITCH_CLK_HI		GENMASK_ULL(31, 16)
+#define MIO_EMM_SWITCH_CLK_LO		GENMASK_ULL(15, 0)
 
 /* Protoypes */
 irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id);
diff --git a/drivers/mmc/host/cavium-pci-thunderx.c b/drivers/mmc/host/cavium-pci-thunderx.c
index 8564612..7dc626a 100644
--- a/drivers/mmc/host/cavium-pci-thunderx.c
+++ b/drivers/mmc/host/cavium-pci-thunderx.c
@@ -155,7 +155,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 static void thunder_mmc_remove(struct pci_dev *pdev)
 {
 	struct cvm_mmc_host *host = pci_get_drvdata(pdev);
-	union mio_emm_dma_cfg dma_cfg;
+	u64 dma_cfg;
 	int i;
 
 	for (i = 0; i < CAVIUM_MAX_MMC; i++)
@@ -164,9 +164,9 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
 			platform_device_del(slot_pdev[i]);
 		}
 
-	dma_cfg.val = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
-	dma_cfg.s.en = 0;
-	writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG(host));
+	dma_cfg = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
+	dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
+	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
 	clk_disable_unprepare(host->clk);
 }
