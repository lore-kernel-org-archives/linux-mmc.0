From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from
 STATE_DATA_ERROR
Date: Mon, 08 Apr 2013 21:17:55 +0900
Message-ID: <003401ce3453$19d1e8c0$4d75ba40$%jun@samsung.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
 <5146EAB0.1030705@samsung.com>
 <CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
 <515E88E3.5070507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <515E88E3.5070507@samsung.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Doug Anderson' <dianders@chromium.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@gmail.com>, 'Bing Zhao' <bzhao@marvell.com>, 'Ashok Nagarajan' <asnagarajan@chromium.org>, 'Paul Stewart' <pstew@chromium.org>, 'Olof Johansson' <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday, April 05, 2013, Jaehoon Chung wrote:
> Hi Doug,
> 
> You're right..it's something wrong.
> Actually i didn't test with your patch, but your commit message is reasonable.
> 
> I will check until next week after test.
Doug Anderson, Jaehoon Chung,

Sorry for late response.
Could I explain this problem more?
I guess Doug are debugging it with wifi, right?
The problem happens when dw_mci_stop_dma is called in the middle of data transfers.
If data error occurs in the end of block, EVENT_XFER_COMPLETE might be set. So, it's fine.
Actually, dw_mci_idmac_stop_dma stops the dma working, there is no further interrupt for dma completion.
There are two solutions we have applied.

#1. deferring the call of dw_mci_stop_dma until EVENT_XFER_COMPLETE flag is set into pending_events.
In this case, dma transfer will be continued with error.

@@ -1062,7 +1062,6 @@ static void dw_mci_tasklet_func(unsigned long priv)
                case STATE_SENDING_DATA:
                        if (test_and_clear_bit(EVENT_DATA_ERROR,
                                               &host->pending_events)) {
-                               dw_mci_stop_dma(host);
                                if (data->stop)
                                        send_stop_cmd(host, data);
                                state = STATE_DATA_ERROR;
@@ -1155,6 +1154,9 @@ static void dw_mci_tasklet_func(unsigned long priv)
                                                &host->pending_events))
                                break;

+                       dw_mci_stop_dma(host);
+                       set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
+
                        state = STATE_DATA_BUSY;
                        break;
                        
#2. set EVENT_XFER_COMPLETE flag when dw_mci_stop_dma is called regardless using_dma.

@@ -299,10 +299,9 @@ static void dw_mci_stop_dma(struct dw_mci *host)
        if (host->using_dma) {
                host->dma_ops->stop(host);
                host->dma_ops->cleanup(host);
-       } else {
-               /* Data transfer was stopped by the interrupt handler */
-               set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
        }
+
+       set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
 }

If you have any opinion, please let me know.

Thanks,
Seungwon Jeon 
> 
> Best Regards,
> Jaehoon Chung
> 
> On 03/27/2013 03:06 AM, Doug Anderson wrote:
> > Jaehoon,
> >
> > On Mon, Mar 18, 2013 at 3:21 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >> Hi Doug,
> >>
> >> Great..i have found the problem like this.
> >> I will check your patch..and share the result.
> >
> > Did you have any time to check this patch?
> >
> > Thanks!
> >
> > -Doug
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
