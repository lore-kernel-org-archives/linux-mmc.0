From: J Freyensee <james_p_freyensee-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5] mmc: documentation of mmc non-blocking request usage
	and design.
Date: Fri, 08 Jul 2011 15:48:23 -0700
Message-ID: <4E178937.8010004@linux.intel.com>
References: <1309933806-2346-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6153483914676278743=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--===============6153483914676278743==
Content-Type: multipart/alternative;
 boundary="------------060607020003010002070602"

This is a multi-part message in MIME format.
--------------060607020003010002070602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2011 11:30 PM, Per Forlin wrote:
> Documentation about the background and the design of mmc non-blocking.
> Host driver guidelines to minimize request preparation overhead.
I'd like to make a couple suggestions on the documentation when 
documenting actual function names.  In general, really state the name of 
the function.  See below for issues.

> Signed-off-by: Per Forlin<per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Randy Dunlap<rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
> ---
> ChangeLog:
>   v2: - Minor updates after proofreading comments from Chris
>   v3: - Minor updates after more comments from Chris
>   v4: - Minor updates after comments from Randy
>   v5: - Fixed one more comment and Acked-by from Randy
>
>   Documentation/mmc/00-INDEX          |    2 +
>   Documentation/mmc/mmc-async-req.txt |   86 +++++++++++++++++++++++++++++++++++
>   2 files changed, 88 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/mmc/mmc-async-req.txt
>
> diff --git a/Documentation/mmc/00-INDEX b/Documentation/mmc/00-INDEX
> index 93dd7a7..a9ba672 100644
> --- a/Documentation/mmc/00-INDEX
> +++ b/Documentation/mmc/00-INDEX
> @@ -4,3 +4,5 @@ mmc-dev-attrs.txt
>           - info on SD and MMC device attributes
>   mmc-dev-parts.txt
>           - info on SD and MMC device partitions
> +mmc-async-req.txt
> +        - info on mmc asynchronous requests
> diff --git a/Documentation/mmc/mmc-async-req.txt b/Documentation/mmc/mmc-async-req.txt
> new file mode 100644
> index 0000000..b7a52ea
> --- /dev/null
> +++ b/Documentation/mmc/mmc-async-req.txt
> @@ -0,0 +1,86 @@
> +Rationale
> +=========
> +
> +How significant is the cache maintenance overhead?
> +It depends. Fast eMMC and multiple cache levels with speculative cache
> +pre-fetch makes the cache overhead relatively significant. If the DMA
> +preparations for the next request are done in parallel with the current
> +transfer, the DMA preparation overhead would not affect the MMC performance.
> +The intention of non-blocking (asynchronous) MMC requests is to minimize the
> +time between when an MMC request ends and another MMC request begins.
> +Using mmc_wait_for_req(), the MMC controller is idle while dma_map_sg and
> +dma_unmap_sg

if dma_unmap_sg/dma_map_sg are complete functions, please add a '()' to it.
> are processing. Using non-blocking MMC requests makes it
> +possible to prepare the caches for next job in parallel with an active
> +MMC request.
> +
> +MMC block driver
> +================
> +
> +The issue_rw_rq() in the MMC block driver is made non-blocking.
Could this be made *_issue_rw_rq() please?  When I see 'issue_rw_rq()', 
I assume it is referring to an entire function with that name.  But I am 
really thinking this is for functions ending with '_issue_rw_rq()', 
right?  Like in mmc_blk_issue_rw_rq()?

Actually, if mmc_blk_issue_rw_rq() is the only function, please just use 
this.
> +The increase in throughput is proportional to the time it takes to
> +prepare (major part of preparations are dma_map_sg and dma_unmap_sg)
> +a request and how fast the memory is. The faster the MMC/SD is
> +the more significant the prepare request time becomes. Roughly the expected
> +performance gain is 5% for large writes and 10% on large reads on a L2 cache
> +platform. In power save mode, when clocks run on a lower frequency, the DMA
> +preparation may cost even more. As long as these slower preparations are run
> +in parallel with the transfer performance won't be affected.
> +
> +Details on measurements from IOZone and mmc_test
> +================================================
> +
> +https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-async-req
> +
> +MMC core API extension
> +======================
> +
> +There is one new public function mmc_start_req().
Is it really meant mmc_start_req*uest*()?  That is what I see in core.c.

Also, is this the actual async API being introduced in this work that is 
to be used by client drivers?  I don't see it being exported with 
EXPORT_SYMBOL()/EXPORT_SYMBOL_GPL() like mmc_request_done() is in the 
linux-next tree (and I just recently pulled it because I had to fix my 
own driver bug :-/).
> +It starts a new MMC command request for a host. The function isn't
> +truly non-blocking. If there is on ongoing async request it waits
> +for completion of that request and starts the new one and returns. It
> +doesn't wait for the new request to complete. If there is no ongoing
> +request it starts the new request and returns immediately.
> +
> +MMC host extensions
> +===================
> +
> +There are two optional hooks -- pre_req() and post_req() -- that the host
Same here...pre_req()/post_req()...are these functions meant to have 
'pre_req()' in the name?  Please use *_pre_req().  Otherwise, just state 
the exact function name.

> +driver may implement in order to move work to before and after the actual
> +mmc_request function is called.
If there is only a couple of mmc request functions being referred to 
here, please just type it out.
> In the DMA case pre_req() may do
> +dma_map_sg() and prepare the DMA descriptor, and post_req runs
> +the dma_unmap_sg.
> +
> +Optimize for the first request
> +==============================
> +
> +The first request in a series of requests can't be prepared in parallel with
> +the previous transfer, since there is no previous request.
> +The argument is_first_req in pre_req() indicates that there is no previous

Minor thing...if 'is_first_req' a function or macro, please add the '()' 
to it.

And please use *_pre_req()/type-out-exact-pre_req() function please.
> +request. The host driver may optimize for this scenario to minimize
> +the performance loss. A way to optimize for this is to split the current
> +request in two chunks, prepare the first chunk and start the request,
> +and finally prepare the second chunk and start the transfer.
> +
> +Pseudocode to handle is_first_req scenario with minimal prepare overhead:
Please add a blank line here after the 'Pseduocode' statement.  I'm only 
suggesting it because there are blank lines in the pseudo-code itself to 
help improve readability.
> +if (is_first_req&&  req->size>  threshold)
> +   /* start MMC transfer for the complete transfer size */
> +   mmc_start_command(MMC_CMD_TRANSFER_FULL_SIZE);
> +
> +   /*
> +    * Begin to prepare DMA while cmd is being processed by MMC.
> +    * The first chunk of the request should take the same time
> +    * to prepare as the "MMC process command time".
> +    * If prepare time exceeds MMC cmd time
> +    * the transfer is delayed, guesstimate max 4k as first chunk size.
> +    */
> +    prepare_1st_chunk_for_dma(req);
> +    /* flush pending desc to the DMAC (dmaengine.h) */
> +    dma_issue_pending(req->dma_desc);
> +
> +    prepare_2nd_chunk_for_dma(req);
> +    /*
> +     * The second issue_pending should be called before MMC runs out
> +     * of the first chunk. If the MMC runs out of the first data chunk
> +     * before this call, the transfer is delayed.
> +     */
> +    dma_issue_pending(req->dma_desc);


--------------060607020003010002070602
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 07/05/2011 11:30 PM, Per Forlin wrote:
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">Documentation about the background and the design of mmc non-blocking.
Host driver guidelines to minimize request preparation overhead.
</pre>
    </blockquote>
    I'd like to make a couple suggestions on the documentation when
    documenting actual function names.&nbsp; In general, really state the
    name of the function.&nbsp; See below for issues.<br>
    <br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">
Signed-off-by: Per Forlin <a class="moz-txt-link-rfc2396E" href="mailto:per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">&lt;per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org&gt;</a>
Acked-by: Randy Dunlap <a class="moz-txt-link-rfc2396E" href="mailto:rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org">&lt;rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org&gt;</a>
---
ChangeLog:
 v2: - Minor updates after proofreading comments from Chris
 v3: - Minor updates after more comments from Chris
 v4: - Minor updates after comments from Randy
 v5: - Fixed one more comment and Acked-by from Randy

 Documentation/mmc/00-INDEX          |    2 +
 Documentation/mmc/mmc-async-req.txt |   86 +++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/mmc/mmc-async-req.txt

diff --git a/Documentation/mmc/00-INDEX b/Documentation/mmc/00-INDEX
index 93dd7a7..a9ba672 100644
--- a/Documentation/mmc/00-INDEX
+++ b/Documentation/mmc/00-INDEX
@@ -4,3 +4,5 @@ mmc-dev-attrs.txt
         - info on SD and MMC device attributes
 mmc-dev-parts.txt
         - info on SD and MMC device partitions
+mmc-async-req.txt
+        - info on mmc asynchronous requests
diff --git a/Documentation/mmc/mmc-async-req.txt b/Documentation/mmc/mmc-async-req.txt
new file mode 100644
index 0000000..b7a52ea
--- /dev/null
+++ b/Documentation/mmc/mmc-async-req.txt
@@ -0,0 +1,86 @@
+Rationale
+=========
+
+How significant is the cache maintenance overhead?
+It depends. Fast eMMC and multiple cache levels with speculative cache
+pre-fetch makes the cache overhead relatively significant. If the DMA
+preparations for the next request are done in parallel with the current
+transfer, the DMA preparation overhead would not affect the MMC performance.
+The intention of non-blocking (asynchronous) MMC requests is to minimize the
+time between when an MMC request ends and another MMC request begins.
+Using mmc_wait_for_req(), the MMC controller is idle while dma_map_sg and
+dma_unmap_sg </pre>
    </blockquote>
    <br>
    if dma_unmap_sg/dma_map_sg are complete functions, please add a '()'
    to it.<br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">are processing. Using non-blocking MMC requests makes it
+possible to prepare the caches for next job in parallel with an active
+MMC request.
+
+MMC block driver
+================
+
+The issue_rw_rq() in the MMC block driver is made non-blocking.</pre>
    </blockquote>
    Could this be made *_issue_rw_rq() please?&nbsp; When I see
    'issue_rw_rq()', I assume it is referring to an entire function with
    that name.&nbsp; But I am really thinking this is for functions ending
    with '_issue_rw_rq()', right?&nbsp; Like in mmc_blk_issue_rw_rq()?<br>
    <br>
    Actually, if mmc_blk_issue_rw_rq() is the only function, please just
    use this.<br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">
+The increase in throughput is proportional to the time it takes to
+prepare (major part of preparations are dma_map_sg and dma_unmap_sg)
+a request and how fast the memory is. The faster the MMC/SD is
+the more significant the prepare request time becomes. Roughly the expected
+performance gain is 5% for large writes and 10% on large reads on a L2 cache
+platform. In power save mode, when clocks run on a lower frequency, the DMA
+preparation may cost even more. As long as these slower preparations are run
+in parallel with the transfer performance won't be affected.
+
+Details on measurements from IOZone and mmc_test
+================================================
+
+https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-async-req
+
+MMC core API extension
+======================
+
+There is one new public function mmc_start_req().</pre>
    </blockquote>
    Is it really meant mmc_start_req<b>uest</b>()?&nbsp; That is what I see
    in core.c.<br>
    <br>
    Also, is this the actual async API being introduced in this work
    that is to be used by client drivers?&nbsp; I don't see it being exported
    with EXPORT_SYMBOL()/EXPORT_SYMBOL_GPL() like mmc_request_done() is
    in the linux-next tree (and I just recently pulled it because I had
    to fix my own driver bug :-/).<br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">
+It starts a new MMC command request for a host. The function isn't
+truly non-blocking. If there is on ongoing async request it waits
+for completion of that request and starts the new one and returns. It
+doesn't wait for the new request to complete. If there is no ongoing
+request it starts the new request and returns immediately.
+
+MMC host extensions
+===================
+
+There are two optional hooks -- pre_req() and post_req() -- that the host</pre>
    </blockquote>
    Same here...pre_req()/post_req()...are these functions meant to have
    'pre_req()' in the name?&nbsp; Please use *_pre_req().&nbsp; Otherwise, just
    state the exact function name.<br>
    <br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">
+driver may implement in order to move work to before and after the actual
+mmc_request function is called. </pre>
    </blockquote>
    If there is only a couple of mmc request functions being referred to
    here, please just type it out.<br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">In the DMA case pre_req() may do
+dma_map_sg() and prepare the DMA descriptor, and post_req runs
+the dma_unmap_sg.
+
+Optimize for the first request
+==============================
+
+The first request in a series of requests can't be prepared in parallel with
+the previous transfer, since there is no previous request.
+The argument is_first_req in pre_req() indicates that there is no previous</pre>
    </blockquote>
    <br>
    Minor thing...if 'is_first_req' a function or macro, please add the
    '()' to it.&nbsp; <br>
    <br>
    And please use *_pre_req()/type-out-exact-pre_req() function please.<br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">
+request. The host driver may optimize for this scenario to minimize
+the performance loss. A way to optimize for this is to split the current
+request in two chunks, prepare the first chunk and start the request,
+and finally prepare the second chunk and start the transfer.
+
+Pseudocode to handle is_first_req scenario with minimal prepare overhead:</pre>
    </blockquote>
    Please add a blank line here after the 'Pseduocode' statement.&nbsp; I'm
    only suggesting it because there are blank lines in the pseudo-code
    itself to help improve readability.<br>
    <blockquote
      cite="mid:1309933806-2346-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
      type="cite">
      <pre wrap="">
+if (is_first_req &amp;&amp; req-&gt;size &gt; threshold)
+   /* start MMC transfer for the complete transfer size */
+   mmc_start_command(MMC_CMD_TRANSFER_FULL_SIZE);
+
+   /*
+    * Begin to prepare DMA while cmd is being processed by MMC.
+    * The first chunk of the request should take the same time
+    * to prepare as the "MMC process command time".
+    * If prepare time exceeds MMC cmd time
+    * the transfer is delayed, guesstimate max 4k as first chunk size.
+    */
+    prepare_1st_chunk_for_dma(req);
+    /* flush pending desc to the DMAC (dmaengine.h) */
+    dma_issue_pending(req-&gt;dma_desc);
+
+    prepare_2nd_chunk_for_dma(req);
+    /*
+     * The second issue_pending should be called before MMC runs out
+     * of the first chunk. If the MMC runs out of the first data chunk
+     * before this call, the transfer is delayed.
+     */
+    dma_issue_pending(req-&gt;dma_desc);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060607020003010002070602--


--===============6153483914676278743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============6153483914676278743==--
