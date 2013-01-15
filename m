From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v4 1/5] mmc: dw_mmc: Add "disable-wp" device tree property
Date: Mon, 14 Jan 2013 22:20:04 -0800
Message-ID: <20130115062004.GA19801@quad.lixom.net>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1357923834-31641-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2013 at 09:03:50AM -0800, Doug Anderson wrote:
> The "disable-wp" property is used to specify that a given SD card slot
> doesn't have a concept of write protect.  This eliminates the need for
> special case code for SD slots that should never be write protected
> (like a micro SD slot or a dev board).
> 
> The dw_mmc driver is special in needing to specify "disable-wp"
> because the lack of a "wp-gpios" property means to use the special
> purpose write protect line.  On some other mmc devices the lack of
> "wp-gpios" means that write protect should be disabled.
> 
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Acked-by: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Acked-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>

Nit below.

> @@ -825,7 +828,13 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>  	struct dw_mci_board *brd = slot->host->pdata;
>  
>  	/* Use platform get_ro function, else try on board write protect */
> -	if (brd->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT)
> +
> +	/*
> +	 * NOTE: DW_MCI_QUIRK_NO_WRITE_PROTECT will be removed in a future
> +	 * patch in the series once reference to it is removed.
> +	 */
> +	if ((brd->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT) ||
> +	    (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT))

Given that it never worked properly, you could have nuked it first and avoid
the extra churn. Still, not a strong enough reason to respin the series, IMHO.


-Olof
