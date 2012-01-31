From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC 1/2] mmc: davinci: Eliminate spurious interrupts
Date: Tue, 31 Jan 2012 11:30:51 +0000
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF43176B8CE@DBDE01.ent.ti.com>
References: <4F1E9194.90608@mvista.com>
	<1327403766-962-1-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1327403766-962-1-git-send-email-ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 24, 2012 at 16:46:05, Ido Yariv wrote:
> The davinci mmc interrupt handler fills the fifo, as long as the DXRDY
> or DRRDY bits are set in the status register.
> 
> If interrupts fire during this loop, they will be handled by the
> handler, but the interrupt controller will still buffer these. As a
> result, the handler will be called again to serve these needlessly. In
> order to avoid these spurious interrupts, keep interrupts masked while
> filling the fifo.
> 
> Signed-off-by: Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> ---

Tested this series on OMAP-L138 EVM using SD card. Observed that number of
interrupts during IO transaction were less compared to earlier and there
was no drop in performance numbers.

Tested-by: Rajashekhara, Sudhakar <sudhakar.raj-l0cyMroinI0@public.gmane.org>

Regards,
Sudhakar
