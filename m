From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] sdhci-esdhc-imx: Correct two register accesses
Date: Tue, 11 Oct 2016 12:18:20 +0300
Message-ID: <4e944cda-05c6-0515-c98d-e90600f63541@intel.com>
References: <1476124792-18441-1-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476124792-18441-1-git-send-email-aaron.brice@datasoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaron Brice <aaron.brice@datasoft.com>, ulf.hansson@linaro.org, aisheng.dong@nxp.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Russell <david.russell@datasoft.com>
List-Id: linux-mmc@vger.kernel.org

On 10/10/16 21:39, Aaron Brice wrote:
>  - The DMA error interrupt bit is in a different position as
>    compared to the sdhci standard.  This is accounted for in
>    many cases, but not handled in the case of clearing the
>    INT_STATUS register by writing a 1 to that location.
>  - The HOST_CONTROL register is very different as compared to
>    the sdhci standard.  This is accounted for in the write
>    case, but not when read back out (which it is in the sdhci
>    code).
> 
> Signed-off-by: Dave Russell <david.russell@datasoft.com>
> Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
