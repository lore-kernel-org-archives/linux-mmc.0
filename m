From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] davinci: MMC: Pass number of SG segments as platform
	data
Date: Wed, 17 Mar 2010 17:34:07 +0530
Message-ID: <14515.1876415641$1268827920@news.gmane.org>
References: <1268397249-7654-1-git-send-email-sudhakar.raj@ti.com>
	<20100315144037.bf47d74f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20100315144037.bf47d74f.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: 'Andrew Morton' <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Mar 16, 2010 at 03:10:37, Andrew Morton wrote:
> On Fri, 12 Mar 2010 18:04:09 +0530
> Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:
> 
> > On some platforms like DM355, the number of EDMA parameter
> > slots available for EDMA_SLOT_ANY usage are few. In such cases,
> > if MMC/SD uses 16 slots for each instance of MMC controller,
> > then the number of slots available for other modules will be
> > very few.
> > 
> > By passing the number of EDMA slots to be used in MMC driver
> > from platform data, EDMA slots available for other purposes
> > can be controlled.
> 
> It's unclear what the runtime effects of this change are.  I assumed
> (without justification) that they're minor and I scheduled the patch for
> 2.6.35.
> 
> If that was the wrong decision then blame the changelog ;)
> 

Most of the platforms will not use this platform data variable. But on DM355,
as the number of EDMA resources available is limited, the number of scatter-
gather segments used inside the MMC driver can be 8 (passed as platform data)
instead of 16. On DM355, when the number of scatter-gather segments was reduced
to 8, I saw a performance difference of about 0.25-0.4 Mbytes/sec during write.
Read performance variations were negligible.

Thanks,
Sudhakar
