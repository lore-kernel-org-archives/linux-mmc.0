From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: [PATCH/RESEND v3 2/2] row: Add support for urgent request handling
Date: Tue, 11 Dec 2012 15:43:20 +0200
Message-ID: <1355233400-26269-3-git-send-email-tlinder@codeaurora.org>
References: <1355233400-26269-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1355233400-26269-1-git-send-email-tlinder@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: jaxboe@fusionio.com
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, venkat@linaro.org, linux-mmc@vger.kernel.org, Tanya Brokhman <tlinder@codeaurora.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

This patch add support for handling urgent requests.
ROW queue can be marked as "urgent". If an urgent queue was
un-served in a previous dispatch cycle and a request was added
to it - it will trigger issuing urgent request to the device driver.

Signed-off-by: Tatyana Brokhman <tlinder@codeaurora.org>

diff --git a/block/row-iosched.c b/block/row-iosched.c
index b3204d6..41cc028 100644
--- a/block/row-iosched.c
+++ b/block/row-iosched.c
@@ -58,6 +58,17 @@ static const bool queue_idling_enabled[] = {
 	false,	/* ROWQ_PRIO_LOW_SWRITE */
 };
 
+/* Flags indicating whether the queue can notify on urgent requests */
+static const bool urgent_queues[] = {
+	true,	/* ROWQ_PRIO_HIGH_READ */
+	true,	/* ROWQ_PRIO_REG_READ */
+	false,	/* ROWQ_PRIO_HIGH_SWRITE */
+	false,	/* ROWQ_PRIO_REG_SWRITE */
+	false,	/* ROWQ_PRIO_REG_WRITE */
+	false,	/* ROWQ_PRIO_LOW_READ */
+	false,	/* ROWQ_PRIO_LOW_SWRITE */
+};
+
 /* Default values for row queues quantums in each dispatch cycle */
 static const int queue_quantum[] = {
 	100,	/* ROWQ_PRIO_HIGH_READ */
@@ -271,7 +282,13 @@ static void row_add_request(struct request_queue *q,
 
 		rqueue->idle_data.last_insert_time = ktime_get();
 	}
-	row_log_rowq(rd, rqueue->prio, "added request");
+	if (urgent_queues[rqueue->prio] &&
+	    row_rowq_unserved(rd, rqueue->prio)) {
+		row_log_rowq(rd, rqueue->prio,
+			     "added urgent req curr_queue = %d",
+			     rd->curr_queue);
+	} else
+		row_log_rowq(rd, rqueue->prio, "added request");
 }
 
 /**
@@ -306,6 +323,29 @@ static int row_reinsert_req(struct request_queue *q,
 	return 0;
 }
 
+/*
+ * row_urgent_pending() - Return TRUE if there is an urgent
+ *			  request on scheduler
+ * @q:	requests queue
+ *
+ */
+static bool row_urgent_pending(struct request_queue *q)
+{
+	struct row_data *rd = q->elevator->elevator_data;
+	int i;
+
+	for (i = 0; i < ROWQ_MAX_PRIO; i++)
+		if (urgent_queues[i] && row_rowq_unserved(rd, i) &&
+		    !list_empty(&rd->row_queues[i].rqueue.fifo)) {
+			row_log_rowq(rd, i,
+				     "Urgent request pending (curr=%i)",
+				     rd->curr_queue);
+			return true;
+		}
+
+	return false;
+}
+
 /**
  * row_remove_request() -  Remove given request from scheduler
  * @q:	requests queue
@@ -697,6 +737,7 @@ static struct elevator_type iosched_row = {
 		.elevator_dispatch_fn		= row_dispatch_requests,
 		.elevator_add_req_fn		= row_add_request,
 		.elevator_reinsert_req_fn	= row_reinsert_req,
+		.elevator_is_urgent_fn		= row_urgent_pending,
 		.elevator_former_req_fn		= elv_rb_former_request,
 		.elevator_latter_req_fn		= elv_rb_latter_request,
 		.elevator_set_req_fn		= row_set_request,
-- 
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. 
Is a member of Code Aurora Forum, hosted by the Linux Foundation
